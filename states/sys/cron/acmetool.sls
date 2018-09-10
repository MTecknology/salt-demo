acmetool_refresh:
  cron.present:
    - identifier: acmetool_refresh
    - name: /usr/bin/acmetool; /usr/sbin/service nginx reload
    - special: '@weekly'
