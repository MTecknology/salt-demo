#!/usr/bin/env python
'''
Author:      Michael Lustfield (MTecknology)
License:     CC BY-NC-ND 4.0
             https://creativecommons.org/licenses/by-nc-nd/4.0/
Description: This script is meant to be triggered via the salt scheduler. It
             reads a counter stored in sdb and drops the value by one. If the
             counter reaches a specified value, a global highstate is triggered
             via the orchestrate runner. Setting the value and the conditions
             in which it's set are handled by separate logic.
'''
import salt.config
import subprocess
import time
from salt.utils.sdb import sdb_get, sdb_set

opts = salt.config.minion_config('/etc/salt/minion')
tick = int(sdb_get('sdb://localsdb/hst_tick', opts))

if tick:
    if tick > 0:
        sdb_set('sdb://localsdb/hst_tick', tick - 1, opts)
    if tick == 10:
        p = subprocess.Popen(
                ['/usr/bin/salt-run', 'state.orch', '_orchestrate.global_highstate'],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
        stdout, stderr = p.communicate()
        if stdout or stderr:
            with open('/var/log/salt/global_highstate.log', 'a') as fh:
                fh.write('{}\n'.format(time.strftime("%c")))
                if stdout:
                    fh.write('{}\n'.format(stdout))
                if stderr:
                    fh.write('{}\n'.format(stderr))
                fh.close()
