include:
  - sys.cron.snap

rsync:
  pkg.installed

rdiff-backup:
  pkg.installed

/usr/local/sbin/snap:
  file.managed:
    - source: salt://usr/local/sbin/snap
    - mode: 750
    - template: jinja

/etc/snap.exclude:
  file.managed:
    - source: salt://etc/snap.exclude
    - template: jinja

/etc/snap.include:
  file.managed:
    - source: salt://etc/snap.include
    - template: jinja
