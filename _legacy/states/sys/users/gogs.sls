gogs-user:
  user.present:
    - name: gogs
    - fullname: "Git User"
    - home: /opt/gogs
    - createhome: False
    - optional_groups:
      - ssh-user
    - require:
      - group: ssh-user
