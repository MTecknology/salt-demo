salt-cloud:
  pkg.installed:
    - pkgs:
      - salt-cloud
      - python-ipy
      - python-netaddr

## files

/etc/salt/cloud.conf.d:
  file.recurse:
    - source: salt://etc/salt/cloud.conf.d
    - template: jinja
    - file_mode: 640
    - dir_mode: 700
    - clean: True
    - require:
      - pkg: salt-cloud

/etc/salt/cloud.deploy.d:
  file.recurse:
    - source: salt://etc/salt/cloud.deploy.d
    - template: jinja
    - file_mode: 640
    - dir_mode: 700
    - clean: True
    - require:
      - pkg: salt-cloud

{% for m in ['master', 'minion'] %}
/etc/salt/{{ m }}.d/cloud.conf:
  file.managed:
    - file_mode: 640
    - require:
      - pkg: salt-{{ m }}
    - listen_in:
      - service: salt-{{ m }}
    - contents: |
        netbox_api_url: http://tab.domain.tld/api/
{% endfor %}

#NOTE: Disabled because I haven't figured it out yet.
## TODO: This can be moved to pillar in Nitrogen
#/etc/salt/cloud.map:
#  file.managed:
#    - source: salt://etc/salt/cloud.map
#    - template: jinja
#    - file_mode: 640
#    - dir_mode: 700
#    - require:
#      - pkg: salt-cloud
