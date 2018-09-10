include:
  - sys.pkgs.sudo
  - sys.users.gogs

gogs-deps:
  pkg.installed:
    - pkgs:
      - git

gogs:
  service.running:
    - require:
      - file: /etc/init.d/gogs
      - archive: gogs-tgz
      - user: gogs-user
    - watch:
      - archive: gogs-tgz

## files

/etc/init.d/gogs:
  file.managed:
    - source: salt://etc/init.d/gogs
    - mode: 755

gogs-tgz:
  archive.extracted:
    - name: /opt/
    - source: https://github.com/gogits/gogs/releases/download/v{{ pillar['pkg_versions']['gogs'] }}/linux_amd64.tar.gz
    - source_hash: md5={{ pillar['pkg_versions']['gogs_md5'] }}
    - if_missing: /opt/gogs/
    - archive_format: tar
    - tar_options: x
    - user: gogs
    - group: gogs
    - require:
      - user: gogs
