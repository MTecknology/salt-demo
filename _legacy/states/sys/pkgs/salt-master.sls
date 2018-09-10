salt-master-deps:
  pkg.installed:
    - pkgs:
      - git
      - python-git
      - python-sqlite

salt-master:
  pkg.installed:
    - require:
      - pkgrepo: saltstack-repo
  service.running:
    - require:
      - pkg: salt-master

## files

{% for conf in ['main', 'options', 'reactor', 'sdb'] %}
/etc/salt/master.d/{{ conf }}.conf:
  file.managed:
    - source:
      - salt://etc/salt/master.d/{{ conf }}.conf%%{{ salt['pillar.get']('salt:file_tag', 'null') }}
      - salt://etc/salt/master.d/{{ conf }}.conf
    - require:
      - pkg: salt-master
    - watch_in:
      - service: salt-master
{% endfor %}

# This is a bit of an odd duck
/etc/salt/minion.d/sdb.conf:
  file.managed:
    - source: salt://etc/salt/master.d/sdb.conf
    - watch_in:
      - service: salt-minion

/srv/reactor:
  file.directory:
    - clean: True
    - mode: 600
    - dir_mode: 700
    - source: salt://srv/reactor

/etc/salt/gpgkeys:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 700
    - mode: 600
