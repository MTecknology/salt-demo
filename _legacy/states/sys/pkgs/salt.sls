{% set debapt = pillar.get('debian_apt', {}) %}

salt-minion:
  pkg.installed:
    - refresh: True
  service.running:
    - watch:
      - file: /etc/salt/minion.d/main.conf

## files

saltstack-repo:
  pkgrepo.managed:
    - humanname: "SaltStack"
    {% if grains['os'] == 'Raspbian' %}
    - name: "deb http://{{ debapt['salt_server'] }}/sltarm{{ debapt['salt_ver'] }} {{ debapt['salt_rel'] }} main"
    {% else %}
    - name: "deb http://{{ debapt['salt_server'] }}/sltstk{{ debapt['salt_ver'] }} {{ debapt['salt_rel'] }} main"
    {% endif %}
    - dist: {{ debapt['salt_rel'] }}
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: salt://etc/apt/keys/DE57BFBE.pub

/etc/salt/minion.d/main.conf:
  file.managed:
    - source: salt://etc/salt/minion.d/main.conf
    - template: jinja
