base:
  '*':
    - sys.files.apt
    - sys.files.gai
    - sys.files.pam
    - sys.files.tzdata
    - sys.pkgs.base
    - sys.pkgs.ferm
    - sys.pkgs.logcheck
    - sys.pkgs.ntp
    - sys.pkgs.salt
    - sys.pkgs.snap
    - sys.pkgs.ssh
    - sys.pkgs.sshguard
    - sys.pkgs.ssmtp
    - sys.pkgs.sudo
    - sys.pkgs.syslog
    - sys.users
  'apt*.domain.tld':
    - sys.pkgs.acng
    - sys.pkgs.nginx
    - sys.pkgs.reprepro
  'backup.domain.tld':
    - sys.pkgs.rsnapshot
    - sys.pkgs.glacier
  'boot*.domain.tld':
    - sys.pkgs.nginx
    - sys.pkgs.tftpd
    - sys.remotes
  'endsalt.domain.tld':
    - sys.pkgs.salt-master
  'git.domain.tld':
    - sys.pkgs.gogs
    - sys.pkgs.nginx
  'inalert00.domain.tld':
    - sys.pkgs.inalert-master
    - sys.pkgs.nginx
    - sys.pkgs.uwsgi
    - sys.files.uwsgi_webapps
  'inalert*.domain.tld':
    - sys.pkgs.inalert
    - sys.pkgs.redis
  'irc.domain.tld':
    - sys.pkgs.gauth
    - sys.misc.michael_lustfield
  'itel*.domain.tld':
    # readme: itel
    - sys.pkgs.acmetool
    - sys.pkgs.elasticsearch
    - sys.pkgs.kibana
    - sys.pkgs.logstash
    - sys.pkgs.nginx
  'oob-endpoint*.domain.tld':
    - sys.pkgs.gauth
    - sys.pkgs.mifi
    - sys.pkgs.openvpn
  'oob-ingress*.domain.tld':
    - sys.pkgs.gauth
    - sys.pkgs.openvpn
  'pbin*.ngx.cc':
    - sys.pkgs.acmetool
    - sys.pkgs.nginx
    - sys.pkgs.uwsgi
    - sys.remotes
  'bot.ngx.cc':
    - sys.pkgs.limnoria
    - sys.users.ngxbot
  'proxmox*.domain.tld':
    - sys.pkgs.proxmox
  'mt-pubweb*.domain.tld':
    - sys.pkgs.gauth
    - sys.webapps.mlustfield
  'salt.domain.tld':
    - sys.pkgs.salt-master
    - sys.pkgs.salt-cloud
    - sys.schedules.global_highstate
  'inventory.domain.tld':
    - sys.pkgs.nginx
    - sys.pkgs.postgresql
    - sys.pkgs.uwsgi
    - sys.pkgs.virtualenv
    - sys.remotes
  'wlc.domain.tld':
    - sys.pkgs.ubiquiti
