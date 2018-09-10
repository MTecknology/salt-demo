sudo:
  pkg.installed

## files

/etc/sudoers:
  file.managed:
    - source: salt://etc/sudoers

{% for file in pillar.get('extra_sudoers', []) %}
/etc/sudoers.d/{{ file }}:
  file.managed:
    - source: salt:///etc/sudoers.d/{{ file }}
    - file_mode: 440
{% endfor %}

{% for file in pillar.get('extra_sudoers_sbin', []) %}
/usr/local/sbin/{{ file }}:
  file.managed:
    - source: salt:///usr/local/sbin/{{ file }}
    - file_mode: 750
{% endfor %}
