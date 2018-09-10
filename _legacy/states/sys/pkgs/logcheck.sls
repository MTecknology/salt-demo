logcheck:
  pkg.installed:
    - pkgs:
      - logcheck
      - logcheck-database

## files

/etc/logcheck/logcheck.conf:
  file.managed:
    - source: salt://etc/logcheck/logcheck.conf

/etc/logcheck/ignore.d.server/mtrules:
  file.managed:
    - source: salt://etc/logcheck/ignore.d.server/mtrules

/etc/cron.d/logcheck:
  file.managed:
    - contents: |
        #!/bin/bash
        # /etc/cron.d/logcheck: crontab entries for the logcheck package

        PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
        MAILTO=root

        @reboot    logcheck  if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi
        7 2 * * *  logcheck  if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck; fi
