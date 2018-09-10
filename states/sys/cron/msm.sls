msm-backup:
  cron.present:
    - name: '/usr/local/sbin/msm all worlds backup >/dev/null'
    - identifier: msm-backup
    - hour: 5
    - minute: 0

msm-backup-cleanup:
  cron.present:
    - name: "find /opt/msm/ -type f -mtime +7 -name '*.zip' -o -name '*.gz' -delete"
    - identifier: msm-backup-cleanup
    - hour: 5
    - minute: 0

msm-logroll:
  cron.present:
    - name: '/usr/local/sbin/msm all logroll >/dev/null'
    - identifier: msm-logroll
    - hour: 3
    - minute: 0

#msm-ramsync:
#  cron.present:
#    - name: '/usr/local/sbin/msm all worlds todisk'
#    - identifier: msm-ramsync
#    - minute: '0,30'
