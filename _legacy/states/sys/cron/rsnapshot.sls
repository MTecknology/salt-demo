rsnapshot_daily:
  cron.present:
    - name: rsnapshot daily
    - minute: 7
    - hour: 1

rsnapshot_weekly:
  cron.present:
    - name: rsnapshot weekly
    - minute: 7
    - hour: 2
    - dayweek: 1

rsnapshot_monthly:
  cron.present:
    - name: rsnapshot monthly
    - minute: 7
    - hour: 3
    - daymonth: 1

upload_backup:
  cron.present:
    - name: /usr/local/sbin/upload_backup
    - minute: 27
    - hour: 4
    - daymonth: '7,22'
