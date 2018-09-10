'base':
  '*':
    - sys.base.apt
    - sys.base.ferm
    - sys.base.snap
    - sys.base.sudo
    - sys.base.syslog
    - sys.base.tzdata
    - sys.pkgs.versions
    - sys.users
    - sys.users.ssmtp
    - sys.websites
    - sys.certs.dhparam
  'apt*.domain.tld':
    - sys.pkgs.acng
  'boot*.domain.tld':
    - sys.pkgs.tftpd
    - sys.remotes
  'endsalt.domain.tld':
    - sys.pkgs.salt
  'inalert*.domain.tld':
    - sys.services.inalert
  'itel.domain.tld':
    - sys.pkgs.acmetool
    - sys.pkgs.logstash
    - sys.pkgs.elasticsearch
  'pbin.ngx.cc':
    - sys.pkgs.acmetool
    - sys.remotes
  'arn-*.domain.tld':
    - sys.vpn
  'arn-scout*.domain.tld':
    - sys.pkgs.udev
  'mlweb*.domain.tld':
    - sys.pkgs.sphinxsearch
    - sys.certs.mlustfield
  'salt.domain.tld':
    - sys.pkgs.salt
    - sys.pkgs.salt-cloud
  'snap.domain.tld':
    - sys.services.glacier
  'netbox.domain.tld':
    - sys.pkgs.postgresql
    - sys.pkgs.virtualenv
    - sys.remotes
