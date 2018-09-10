include:
  - sys.users.kibana

kibana:
  service.running:
    - require:
      - archive: kibana-app
      - file: /etc/init.d/kibana
      - user: kibana-user
    - watch:
      - archive: kibana-app
      #- file: /opt/kibana/settings.json

## files

/srv/kibana:
  file.directory

kibana-app:
  archive.extracted:
    - name: /opt/kibana/
    - source: https://download.elastic.co/kibana/kibana/kibana-{{ pillar['pkg_versions']['kibana'] }}-linux-x64.tar.gz
    - source_hash: md5=bb52377494d4cd8aef0885f76f9a7b2e
    - archive_format: tar
    - if_missing: /opt/kibana/kibana-{{ pillar['pkg_versions']['kibana'] }}-linux-x64/
    - user: kibana
    - group: kibana
    - require:
      - user: kibana-user

/opt/kibana/current:
  file.symlink:
    - target: /opt/kibana/kibana-{{ pillar['pkg_versions']['kibana'] }}-linux-x64
    - require:
      - archive: kibana-app

/etc/init.d/kibana:
  file.managed:
    - source: salt://etc/init.d/kibana
    - mode: 755
