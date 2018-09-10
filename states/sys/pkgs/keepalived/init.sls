keepalived:
  pkg.installed:
    - name: keepalived
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://etc/keepalived/keepalived.conf
    - template: jinja
    - require:
      - pkg: keepalived
  service.running:
    - reload: True
    - require:
      - file: keepalived
    - onchanges:
      - file: keepalived
