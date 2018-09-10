{% from 'sys/pkgs/udev/defaults.sls' import conf with context -%}
udev:
  pkg.installed

{% for rule in pillar['udev']['rules'] %}
/etc/udev/rules.d/{{ rule }}:
  file.managed:
    - source: salt://etc/udev/rules.d/{{ rule }}
{% endfor %}
{% endif %}
