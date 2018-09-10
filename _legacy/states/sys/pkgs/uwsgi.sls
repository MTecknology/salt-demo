include:
  - sys.users.www-data

uwsgi:
  pkg.installed:
    - pkgs:
      - uwsgi
      {% for dep in salt['pillar.get']('uwsgi-deps', []) %}
      - {{ dep }}
      {% endfor %}
  service.running:
    - enable: True
    - watch:
      {% for site in salt['pillar.get']('uwsgi-apps', []) %}
      - file: /etc/uwsgi/apps-enabled/{{ site }}.ini
      - file: /etc/uwsgi/apps-available/{{ site }}.ini
      {% endfor %}
    - require:
      - user: www-data
      - pkg: uwsgi

## files

{% for site in pillar.get('uwsgi-apps', []) %}
/etc/uwsgi/apps-available/{{ site }}.ini:
  file.managed:
    - source: salt://etc/uwsgi/apps-available/{{ site }}.ini
    - user: root
    - clean: True
    - require:
      - pkg: uwsgi

/etc/uwsgi/apps-enabled/{{ site }}.ini:
  file.symlink:
    - target: /etc/uwsgi/apps-available/{{ site }}.ini
    - require:
      - pkg: uwsgi
{% endfor %}
