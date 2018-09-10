global_highstate:
  schedule.present:
    - function: cmd.run
    - job_args:
      - /usr/local/sbin/global_highstate
    - seconds: 60
