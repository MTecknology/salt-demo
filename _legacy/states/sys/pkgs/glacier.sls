glacier-deps:
  pkg.installed:
    - pkgs:
      - openjdk-7-jre

# Note file was pulled from:
#   https://github.com/MoriTanosuke/glacieruploader
/usr/local/sbin/glacier.jar:
  file.managed:
    - source: salt://usr/local/sbin/glacier.jar

## files

/root/.glacier_creds:
  file.managed:
    - source: salt://root/glacier_creds
    - template: jinja
    - context:
        aws_access: {{ pillar["glacier"]["aws_access"] }}
        aws_secret: {{ pillar["glacier"]["aws_secret"] }}
    - mode: 600

/root/.glacieruploaderrc:
  file.managed:
    - source: salt://root/glacieruploaderrc
    - template: jinja
    - context:
        aws_region: {{ pillar["glacier"]["aws_region"] }}
    - mode: 600
