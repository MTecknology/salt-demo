include:
  - sys.cron.snap

rsync:
  pkg.installed

## files

/usr/local/sbin/snap:
  file.managed:
    - source: salt://usr/local/sbin/snap
    - mode: 750
    - template: jinja

/etc/snap.exclude:
  file.managed:
    - source: salt://etc/snap.exclude
    - template: jinja
