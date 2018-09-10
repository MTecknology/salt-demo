sshguard:
  pkg.installed:
    - name: sshguard
  service.running:
    - enable: True
    - require:
      - pkg: sshguard
    - require_in:
      - file: /etc/ferm/ferm.conf

## files

/etc/sshguard/whitelist:
  file.managed:
    - require:
      - pkg: sshguard
    - watch_in:
      - service: sshguard
    - contents: |
        # /usr/share/doc/sshguard/examples/whitelistfile.example
        # Address blocks in CIDR notation
        127.0.0.0/8
        10.41.0.0/16
        10.42.0.0/16
        ::1/128
