{##
 # After highstate:
 #
 ## Init:
 #  su -
 #  msm update
 #  #(vanilla) msm jargroup create minecraft minecraft
 #
 ## BungeeCord Gateway:
 #  mkdir /opt/bungee; cd /opt/bungee; chown msm:msm /opt/bungee
 #  wget 'https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar' -O BungeeCord.jar
 #
 ## Spigot Build:
 #  mkdir /opt/spigot; cd /opt/spigot
 #  wget 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar' -O BuildTools.jar
 #  java -jar BuildTools.jar  # --rev 1.12.2
 #  msm jargroup create spigot http://127.0.0.1/spigot-latest.jar
 #  ln -sf spigot-1.12.2.jar spigot-latest.jar
 #  msm jargroup getlatest spigot
 #
 ## New Server:
 #  msm server create <server-name>
 #  echo 'eula=true' > /opt/msm/servers/<server-name>/eula
 #  cp /etc/msm.defaults /opt/msm/servers/<server-name>/server.properties
 #  # Increment port number by one higher than last
 #  msm server <server-name> start
 #  # bungeecord: true in spigot.yml
 #  # connection-throttle: -1 in bukkit.yml
 #  msm server <server-name> restart
 ##}

include:
  - sys.cron.msm
  - sys.users.msm

msm:
  pkg.installed:
    - names:
      - git
      - openjdk-8-jre-headless
      - rsync
      - screen
      - zip
  git.latest:
    - name: https://github.com/msmhq/msm.git
    - target: /opt/msm-repo
    - force_reset: True
    - require:
      - pkg: msm
  file.managed:
    - name: /etc/systemd/system/msm.service
    - source: salt://etc/systemd/system/msm.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: msm
  service.running:
    - enable: True
    - require:
      - git: msm
      - file: msm
      - file: /etc/msm.conf
      - file: /usr/local/sbin/msm
      - user: msm-user
    - watch:
      - git: msm
      - file: /etc/msm.conf
      - module: msm

/usr/local/sbin/msm:
  file.symlink:
    - target: /opt/msm-repo/init/msm

/etc/msm.conf:
  file.managed:
    - source: salt://etc/msm/msm.conf

/etc/logcheck/ignore.d.server/msm:
  file.managed:
    - source: salt://etc/logcheck/ignore.d.server/msm

##
# Spigot
##

/etc/msm.defaults:
  file.managed:
    - source: salt://etc/msm/defaults

# dirty hack

nginx-light:
  pkg.installed:
    - name: nginx-light
  file.absent:
    - name: /etc/nginx/sites-enabled/default
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - file: nginx-light
      - file: ngxspigot

ngxspigot:
  file.managed:
    - name: /etc/nginx/conf.d/msm.conf
    - contents: |
        server {
            listen 127.0.0.1;
            server_name _ default_server;
            root /opt/spigot;
        }
        server {
            listen 80 default_server;
            listen [::]:80 default_server;
            server_name mc.domain.tld;
            root /opt/resources;
        }

##
# BungeeCord
##

bungee:
  file.managed:
    - name: /etc/systemd/system/bungee.service
    - source: salt://etc/systemd/system/bungee.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: bungee
  service.running:
    - enable: True
    - require:
      - file: bungee
      - pkg: msm
    - watch:
      - module: bungee
