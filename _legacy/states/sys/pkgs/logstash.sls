logstash-deps:
  pkg.installed:
    - pkgs:
      - openjdk-7-jre

logstash:
  pkg.installed:
    - refresh: True
    - require:
      - pkg: logstash-deps
      - pkgrepo: logstash-repo
  service.running:
    - require:
      - pkg: logstash
    - watch:
      - file: /etc/default/logstash
      {% for config in salt['pillar.get']('logstash:configs', []) %}
      - file: /etc/logstash/conf.d/{{ config }}
      {% endfor %}
      {% for config in salt['pillar.get']('logstash:templates', []) %}
      - file: /etc/logstash/templates/{{ template }}
      {% endfor %}
      {% for config in salt['pillar.get']('logstash:patterns', []) %}
      - file: /etc/logstash/patterns/{{ pattern }}
      {% endfor %}

## files

logstash-repo:
  pkgrepo.managed:
    - humanname: "elastic.co logstash"
    - name: "deb http://apt.domain.tld/logstash stable main"
    - dist: stable
    - file: /etc/apt/sources.list.d/logstash.list
    - key_url: salt://etc/apt/keys/D88E42B4.pub

/etc/default/logstash:
  file.managed:
    - source: salt://etc/default/logstash
    - template: jinja

# Basic structure for incoming/archived data
{% for dir in ['/srv/logstash', '/srv/logstash/incoming', '/srv/logstash/archived'] %}
{{ dir }}:
  file.directory:
    - user: logstash
    - group: logstash
    - dir_mode: 750
    - require:
      - pkg: logstash
{% endfor %}

# Directories to drop logstash configs into.
{% for dir in ['/etc/logstash', '/etc/logstash/conf.d', '/etc/logstash/templates', '/etc/logstash/patterns'] %}
{{ dir }}:
  file.directory:
    - user: logstash
    - group: logstash
    - dir_mode: 750
{% endfor %}

{% if 'logstash' in pillar %}
{% if 'configs' in pillar['logstash'] %}{% for config in pillar['logstash']['configs'] %}
/etc/logstash/conf.d/{{ config }}:
  file.managed:
    - template: jinja
    - source: salt://etc/logstash/conf.d/{{ config }}
    - watch_in:
      - service: logstash
    - require:
      - file: /etc/logstash/conf.d
{% endfor %}{% endif %}

{% if 'templates' in pillar['logstash'] %}{% for template in pillar['logstash']['templates'] %}
/etc/logstash/templates/{{ template }}:
  file.managed:
    - source: salt://etc/logstash/templates/{{ template }}
    - template: jinja
    - watch_in:
      - service: logstash
    - require:
      - file: /etc/logstash/templates
{% endfor %}{% endif %}

{% if 'patterns' in pillar['logstash'] %}{% for pattern in pillar['logstash']['patterns'] %}
/etc/logstash/patterns/{{ pattern }}:
  file.managed:
    - source: salt://etc/logstash/patterns/{{ pattern }}
    - template: jinja
    - watch_in:
      - service: logstash
    - require:
      - file: /etc/logstash/patterns
{% endfor %}{% endif %}
{% endif %}
