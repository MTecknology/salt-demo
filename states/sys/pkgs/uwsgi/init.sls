{% from 'sys/pkgs/uwsgi/defaults.sls' import conf with context -%}
include:
  - sys.users.www-data

uwsgi:
  pkg.installed:
    - pkgs:
      - uwsgi
      {% for dep in conf['deps'] %}
      - {{ dep }}
      {% endfor %}
  service.running:
    - enable: True
    - require:
      - user: www-data
      - pkg: uwsgi

{% for site in conf['apps'] %}
/etc/uwsgi/apps-enabled/{{ site }}.ini:
  file.managed:
    - source: salt://etc/uwsgi/apps-enabled/{{ site }}.ini
    - follow_symlinks: False
    - user: root
    - clean: True
    - require:
      - pkg: uwsgi
    - listen_in:
      - service: uwsgi
{% endfor %}

{% for site, target in conf['app-links'].items() %}
/etc/uwsgi/apps-enabled/{{ site }}.ini:
  file.symlink:
    - target: {{ target }}
    - require:
      - pkg: uwsgi
    - listen_in:
      - service: uwsgi
{% endfor %}
