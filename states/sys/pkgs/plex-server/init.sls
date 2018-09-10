include:
  - sys.users.plex
  - sys.pkgs.git-client

plex:
  pkgrepo.managed:
    - humanname: "Plex Repo"
    - name: "deb https://downloads.plex.tv/repo/deb ./public main"
    - dist: "./public"
    - file: /etc/apt/sources.list.d/plex.list
    - key_url: salt://etc/apt/keys/3ADCA79D.pub
  pkg.installed:
    - name: plexmediaserver
    - refresh: True
    - require:
      - pkgrepo: plex
      - user: plex-user
  service.running:
    - name: plexmediaserver
    - require:
      - pkg: plex

/home/plex:
  file.directory:
    - user: plex
    - group: plex
    - require:
      - user: plex

/srv/plex:
  file.directory:
    - user: plex
    - group: plex
    - dir_mode: "750"
    - require:
      - user: plex


##
# https://sabnzbd.org/
# & http://plex.domain.tld:8080/
# Hack:
#   x=$((9000 + RANDOM % 1000))
#   adduser --uid $x avahi
#   vim /etc/avahi/avahi-daemon.conf
#     comment: rlimit-nproc = 3
# Usenet:
#   https://accounts.usenetserver.com/
##
sabnzbdplus:
  pkg.installed:
    - pkgs:
      - sabnzbdplus
      - unrar-free
  service.running:
    - enable: True
    - require:
      - pkg: sabnzbdplus
      - service: plex
      - file: /home/plex
    - watch:
      - file: sabnzbdplus
  file.managed:
    - name: /etc/default/sabnzbdplus
    - source: salt://etc/default/sabnzbdplus


##
# https://github.com/CouchPotato/CouchPotatoServer/
# & http://plex.domain.tld:5050/
# Download App: Sabnzbd :: localhost:8080transmission
##
couchpotato:
  pkg.installed:
    - pkgs:
      - python3-openssl
  git.latest:
    - name: https://github.com/CouchPotato/CouchPotatoServer.git
    - target: /opt/couchpotato
    - require:
      - pkg: git-client
  service.running:
    - enable: True
    - require:
      - git: couchpotato
      - cmd: couchpotato
      - file: couchpotato
  file.symlink:
    - name: /etc/systemd/system/couchpotato.service
    - target: /opt/couchpotato.service
    - require:
      - git: couchpotato
      - file: /opt/couchpotato.service
  cmd.wait:
    - name: systemctl daemon-reload
    - require:
      - file: couchpotato

/opt/couchpotato.service:
  file.managed:
    - source: salt://opt/couchpotato.service
    - require:
      - file: /home/plex

##
sickrage:
  pkg.installed:
    - pkgs:
      - nodejs-legacy
      - unrar-free
  git.latest:
    - name: https://github.com/SickRage/SickRage
    - target: /opt/sickrage
    - user: plex
    - require:
      - pkg: git-client
  service.running:
    - enable: True
    - require:
      - git: sickrage
      - cmd: sickrage
      - file: sickrage
  file.symlink:
    - name: /etc/systemd/system/sickrage.service
    - target: /opt/sickrage.service
    - require:
      - git: couchpotato
      - file: /opt/sickrage.service
  cmd.wait:
    - name: systemctl daemon-reload
    - require:
      - file: couchpotato

/opt/sickrage.service:
  file.managed:
    - source: salt://opt/sickrage.service
    - require:
      - file: /home/plex
