include:
  - sys.cron.rsnapshot
  - sys.users.rsnapshot

rsnapshot:
  pkg.installed

squashfs-tools:
  pkg.installed

/var/rsnapshot:
  file.directory:
    - mode: 700

/etc/rsnapshot.conf:
  file.managed:
    - source: salt://etc/rsnapshot.conf

/etc/cron.d/run_rsnapshot:
  file.managed:
    - source: salt://etc/cron.d/run_rsnapshot

/usr/local/sbin/upload_backup:
  file.managed:
    - source: salt://usr/local/sbin/upload_backup
    - template: jinja
    - mode: 750
