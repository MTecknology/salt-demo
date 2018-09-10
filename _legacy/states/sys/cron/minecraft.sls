msm_backup:
  cron.present:
    - identifier: msm_backup
    - name: /etc/init.d/msm all worlds backup
    - user: minecraft
    - minute: 2
    - hour: 5
    - require:
      - user: minecraft-user

msm_logroll:
  cron.present:
    - identifier: msm_logroll
    - name: /etc/init.d/msm all logroll
    - user: minecraft
    - minute: 50
    - hour: 4
    - require:
      - user: minecraft-user

msm_todisk:
  cron.present:
    - identifier: msm_todisk
    - name: /etc/init.d/msm all worlds todisk
    - user: minecraft
    - minute: 0,30
    - require:
      - user: minecraft-user
