{% for site in pillar.get('uwsgi-apps', []) %}
/srv/webapps/{{ site }}:
  file.recurse:
    - source: salt://srv/webapps/{{ site }}
    - user: root
    - clean: True
    - require_in:
      - service: uwsgi
{% endfor %}
