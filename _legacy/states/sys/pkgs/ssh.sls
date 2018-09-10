ssh:
  pkg.installed:
    - name: openssh-server
  service.running:
    - require:
      - pkg: ssh
    - watch:
      - file: /etc/ssh/sshd_config

## files

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://etc/ssh/sshd_config
    - template: jinja
