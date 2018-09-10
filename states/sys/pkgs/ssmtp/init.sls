ssmtp:
  pkg.installed

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://etc/ssmtp/ssmtp.conf
    - template: jinja
    - require:
      - pkg: ssmtp

/etc/logcheck/ignore.d.server/ssmtp:
  file.managed:
    - user: root
    - group: logcheck
    - replace: False
