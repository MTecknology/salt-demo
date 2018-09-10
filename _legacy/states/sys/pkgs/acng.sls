apt-cacher-ng:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/apt-cacher-ng/acng.conf
      - file: /etc/apt-cacher-ng/security.conf

## files

/etc/apt-cacher-ng/acng.conf:
  file.managed:
    - require:
      - pkg: apt-cacher-ng
    - contents: |
        CacheDir: /var/cache/apt-cacher-ng
        LogDir: /var/log/apt-cacher-ng
        ReportPage: acng-report.html
        ForceManaged: 1
        # Offlinemode: 0

        Remap-debian:   /debian   ; file:backends_debian
        Remap-debsec:   /debsec   ; http://security.debian.org
        Remap-sltstk9:  /sltstk9  ; http://repo.saltstack.com/apt/debian/9/amd64/latest
        Remap-sltarm8:  /sltarm8  ; http://repo.saltstack.com/apt/debian/8/armhf/latest
        Remap-unifi:    /unifi    ; http://dl-origin.ubnt.com/unifi/debian
        Remap-acmetool: /acmetool ; http://ppa.launchpad.net/hlandau/rhea/ubuntu
        Remap-raspmain: /raspmain ; http://raspbian-us.ngc292.space/raspbian/
        Remap-rasparch: /rasparch ; http://archive.raspberrypi.org/debian
        Remap-proxmox:  /proxmox  ; http://download.proxmox.com/debian

/etc/apt-cacher-ng/security.conf:
  file.managed:
    - source: salt://etc/apt-cacher-ng/security.conf
    - template: jinja
    - context:
        users: {{ pillar['acng_creds'] }}
    - require:
      - pkg: apt-cacher-ng
