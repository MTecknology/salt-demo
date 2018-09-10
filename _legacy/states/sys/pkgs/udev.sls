udev:
  pkg.installed

## files

{% if 'rules' in pillar['udev'] %}
{% for rule in pillar['udev']['rules'] %}
/etc/udev/rules.d/{{ rule }}:
  file.managed:
    - source: salt://etc/udev/rules.d/{{ rule }}
{% endfor %}
{% endif %}
