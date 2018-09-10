rsnapshot_weekly:
  cron.present:
    - name: rsnapshot weekly
    - minute: 7
    - hour: 2
    - dayweek: 1

upload_backup:
  cron.present:
    - name: /usr/local/sbin/upload_backup
    - minute: 27
    - hour: 4
    - daymonth: '7,22'
