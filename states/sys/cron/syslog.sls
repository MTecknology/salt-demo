compress_logs:
  cron.present:
    - name: find /srv/hosts -mtime +1 -name '*.log' -exec nice -19 gzip -7 "{}" \;
    - identifier: compress_logs
    - user: root
    - hour: 1
    - minute: 0

delete_logs:
  cron.present:
    - name: find /srv/hosts -mtime +730 -name '*.log.gz' -exec rm "{}" \;
    - identifier: delete_logs
    - user: root
    - hour: 2
    - minute: 0

delete_empty:
  cron.present:
  - name: find /srv/hosts -type d -empty ! -name 'lost+found' -exec rmdir "{}" \;
  - identifier: delete_empty
  - user: root
  - hour: 3
  - minute: 0
