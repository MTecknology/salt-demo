rsyslog:
  pkg.installed:
    - require:
      - file: /etc/rsyslog.d/log.conf
  service.running:
    - require:
      - pkg: rsyslog
    - watch:
      - file: /etc/rsyslog.d/log.conf

## files

/etc/rsyslog.d/log.conf:
  file.managed:
    - source: {{ pillar['syslog_conf'] }}
