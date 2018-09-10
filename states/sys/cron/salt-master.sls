global-highstate:
  cron.present:
    - identifier: global-highstate
    - name: /usr/local/sbin/global_highstate
    - minute: '*'
    - hour: '*'
