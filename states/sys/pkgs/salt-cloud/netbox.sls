{% from 'sys/pkgs/salt-cloud/defaults.sls' import conf with context -%}
{# Skeleton bits required to query netbox. #}

salt-cloud:
  pkg.installed:
    - pkgs:
      - salt-cloud
      - python-ipy
      - python-netaddr

{% set m = 'minion' %}
/etc/salt/{{ m }}.d/cloud.conf:
  file.managed:
    - mode: 640
    - require:
      - pkg: salt-{{ m }}
    - listen_in:
      - service: salt-{{ m }}
    - contents: |
        netbox_api_url: {{ conf['netbox_api_url'] }}
