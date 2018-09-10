{% from 'sys/pkgs/salt-master/defaults.sls' import conf with context -%}
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

{% for cfile in ['main', 'options', 'reactor', 'sdb'] %}
/etc/salt/master.d/{{ cfile }}.conf:
  file.managed:
    - source:
      - salt://etc/salt/master.d/{{ cfile }}.conf%%{{ conf['file_tag'] }}
      - salt://etc/salt/master.d/{{ cfile }}.conf
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
