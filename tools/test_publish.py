"""Publisher ownership and supervisor retry regressions; uses disposable repos."""
import io
import os
from pathlib import Path
import subprocess
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import Mock, patch

import publish
import tray_app


class PublishOwnershipTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='publish-test-')
        self.addCleanup(self.tmp.cleanup)
        self.repo = Path(self.tmp.name)
        (self.repo / 'cachedata').mkdir()
        (self.repo / 'tools').mkdir()
        (self.repo / 'docs').mkdir()
        (self.repo / 'README.md').write_text('base\n')
        (self.repo / 'cachedata' / 'data.txt').write_text('before\n')
        (self.repo / 'tools' / 'example.py').write_text('pass\n')
        self.git('init', '-q')
        self.git('config', 'user.name', 'Test')
        self.git('config', 'user.email', 'test' + chr(64) + 'invalid')
        self.git('add', '-A')
        self.git('commit', '-qm', 'base')
        self.before = self.git('rev-parse', 'HEAD')
        self.patch_value('REPO', str(self.repo))
        self.patch_value('DATA', str(self.repo / 'cachedata'))
        self.consolidate = self.patch_value('consolidate', Mock(return_value=True))
        self.audit = self.patch_value('audit', Mock(return_value=True))
        self.patch_value('sync_tools', Mock(return_value=[]))
        self.patch_value('sync_data', Mock(return_value=0))
        self.push = self.patch_value('stream', Mock(return_value=(0, [])))
        self.patch_value('git', publish.git)

    def patch_value(self, name, value):
        p = patch.object(publish, name, value)
        self.addCleanup(p.stop)
        return p.start()

    def git(self, *args):
        return subprocess.run(['git', '-C', str(self.repo), *args],
                              capture_output=True, text=True, check=True).stdout.strip()

    def test_untracked_draft_survives_and_is_not_committed(self):
        draft = self.repo / 'docs' / 'AGENT-PROMPT.md'
        draft.write_text('unfinished draft\n')
        (self.repo / 'cachedata' / 'data.txt').write_text('after\n')
        self.assertTrue(publish._publish(False))
        self.audit.assert_called_once()
        self.assertEqual(draft.read_text(), 'unfinished draft\n')
        self.assertEqual(self.git('show', '--format=', '--name-only', 'HEAD'),
                         'cachedata/data.txt')
        self.assertEqual(self.git('status', '--porcelain'), '?? docs/')
        self.assertEqual(self.git('ls-files', 'docs'), '')

    def test_tracked_edit_stops_before_consolidating(self):
        (self.repo / 'README.md').write_text('my unfinished edit\n')
        self.assertFalse(publish._publish(True))
        self.consolidate.assert_not_called()
        self.push.assert_not_called()
        self.assertEqual(self.git('rev-parse', 'HEAD'), self.before)

    def test_staged_tool_stops_even_with_no_data_changes(self):
        (self.repo / 'tools' / 'example.py').write_text('print(1)\n')
        self.git('add', 'tools/example.py')
        self.assertFalse(publish._publish(True))
        self.consolidate.assert_not_called()
        self.push.assert_not_called()
        self.assertEqual(self.git('diff', '--cached', '--name-only'), 'tools/example.py')

    def test_staged_draft_is_not_treated_as_untracked(self):
        (self.repo / 'docs' / 'AGENT-PROMPT.md').write_text('draft\n')
        self.git('add', 'docs/AGENT-PROMPT.md')
        self.assertFalse(publish._publish(True))
        self.consolidate.assert_not_called()
        self.push.assert_not_called()

    def test_failed_audit_prevents_commit_and_push(self):
        (self.repo / 'cachedata' / 'data.txt').write_text('not audited\n')
        self.audit.return_value = False
        self.assertFalse(publish._publish(True))
        self.assertEqual(self.git('rev-parse', 'HEAD'), self.before)
        self.push.assert_not_called()

    def test_mid_run_staged_edit_still_blocks_commit(self):
        (self.repo / 'cachedata' / 'data.txt').write_text('after\n')
        def edit_during_audit():
            (self.repo / 'tools' / 'example.py').write_text('print(2)\n')
            self.git('add', 'tools/example.py')
            return True
        self.audit.side_effect = edit_during_audit
        self.assertFalse(publish._publish(True))
        self.assertEqual(self.git('rev-parse', 'HEAD'), self.before)
        self.push.assert_not_called()


class BusyTests(unittest.TestCase):
    def test_contended_publish_never_runs_pipeline(self):
        with patch.object(publish, 'Lock') as lock, patch.object(publish, '_publish') as run:
            lock.return_value.__enter__.return_value.held = False
            self.assertIsNone(publish.publish(True))
            run.assert_not_called()

    def test_cli_busy_has_distinct_exit_status(self):
        with patch.object(publish, 'publish', return_value=None):
            self.assertEqual(publish.main([]), publish.BUSY_EXIT)
        with patch.object(publish, 'publish', return_value=False):
            self.assertEqual(publish.main([]), 1)
        with patch.object(publish, 'publish', return_value=True):
            self.assertEqual(publish.main([]), 0)

    def test_runner_describes_busy_as_waiting(self):
        log = Mock()
        runner = tray_app.Runner(log, Mock())
        proc = SimpleNamespace(stdout=io.StringIO('lock held\n'), wait=lambda: publish.BUSY_EXIT)
        with patch.object(tray_app.subprocess, 'Popen', return_value=proc):
            self.assertEqual(runner.run(False, 'test'), publish.BUSY_EXIT)
        self.assertIsNone(runner.last_ok)
        self.assertIn('waiting', runner.last_result)
        self.assertNotIn('FAILED', runner.last_result)
        self.assertFalse(runner.busy.is_set())

    def test_watcher_keeps_busy_submission_pending_without_failure_backoff(self):
        app = SimpleNamespace(state={'push': True, 'tidy': True}, log=Mock(),
                              runner=SimpleNamespace(run=Mock(return_value=publish.BUSY_EXIT)))
        watcher = tray_app.Watcher(app)
        watcher.failures = 3
        with patch.object(tray_app.time, 'time', return_value=1000), \
             patch.object(tray_app, 'tidy_inbox') as tidy:
            watcher.consolidate_and_settle_up([], {'pending.zip': (1, 2)})
        self.assertEqual(watcher.failures, 3)
        self.assertEqual(watcher.next_attempt, 1000 + tray_app.POLL_SECONDS)
        self.assertEqual(watcher.handled, {})
        tidy.assert_not_called()

    def test_cli_watcher_retries_unchanged_submission_after_failure(self):
        with patch.object(publish, 'inbox_fingerprint', return_value=['submission']), \
             patch.object(publish, 'settled', return_value=True), \
             patch.object(publish, 'publish', side_effect=[False, True]) as run, \
             patch.object(publish.time, 'sleep', side_effect=[None, KeyboardInterrupt]):
            with self.assertRaises(KeyboardInterrupt):
                publish.main(['--watch'])
        self.assertEqual(run.call_count, 2)


if __name__ == '__main__':
    unittest.main()