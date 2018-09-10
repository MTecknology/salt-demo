gitolite:
  pkg.installed:
    - name: gitolite3
    - debconf: salt://_debconf/gitolite3

/etc/gitolite3/gitolite.rc:
  file.managed:
    - source: salt://etc/gitolite3/gitolite.rc
