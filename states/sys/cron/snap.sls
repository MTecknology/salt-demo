snap:
  cron.present:
    - identifier: snap
    - name: /usr/local/sbin/snap
    - hour: 2,10,18
    - minute: random
