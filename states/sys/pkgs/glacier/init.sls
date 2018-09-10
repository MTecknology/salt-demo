glacier-deps:
  pkg.installed:
    - pkgs:
      - default-jre-headless

# Note file was pulled from:
#   https://github.com/MoriTanosuke/glacieruploader
/usr/local/sbin/glacier.jar:
  file.managed:
    - source: salt://usr/local/sbin/glacier.jar

/root/.glacier_creds:
  file.managed:
    - source: salt://root/glacier_creds
    - template: jinja
    - mode: 600

/root/.glacieruploaderrc:
  file.managed:
    - source: salt://root/glacieruploaderrc
    - template: jinja
    - mode: 600
