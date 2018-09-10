acmetool-refresh:
  cron.present:
    - identifier: acmetool-refresh
    - name: /usr/bin/acmetool; /usr/sbin/service nginx reload
    - special: '@weekly'
