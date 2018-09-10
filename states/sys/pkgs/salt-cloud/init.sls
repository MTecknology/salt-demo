{% from 'sys/pkgs/salt-cloud/defaults.sls' import conf with context -%}
salt-cloud:
  pkg.installed:
    - pkgs:
      - salt-cloud
      - python-ipy
      - python-netaddr

{% for d in ['conf', 'deploy', 'providers', 'profiles'] %}
/etc/salt/cloud.{{ d }}.d:
  file.recurse:
    - source: salt://etc/salt/cloud.{{ d }}.d
    - template: jinja
    - file_mode: 640
    - dir_mode: 700
    - clean: True
    - require:
      - pkg: salt-cloud
{% endfor %}

{% for m in ['master', 'minion'] %}
/etc/salt/{{ m }}.d/cloud.conf:
  file.managed:
    - file_mode: 640
    - require:
      - pkg: salt-{{ m }}
    - listen_in:
      - service: salt-{{ m }}
    - contents: |
        netbox_api_url: {{ conf['netbox_api_url'] }}
{% endfor %}

/etc/salt/cloud.map:
  file.managed:
    - source: salt://etc/salt/cloud.map
    - template: jinja
    - file_mode: 640
    - require:
      - pkg: salt-cloud
