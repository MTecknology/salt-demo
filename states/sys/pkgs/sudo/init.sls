{% from 'sys/pkgs/sudo/defaults.sls' import conf with context -%}
sudo:
  pkg.installed

/etc/sudoers:
  file.managed:
    - source: salt://etc/sudoers

{% for file in conf['extra_conf'] %}
/etc/sudoers.d/{{ file }}:
  file.managed:
    - source: salt:///etc/sudoers.d/{{ file }}
    - mode: 440
{% endfor %}

{% for file in conf['extra_sbin'] %}
/usr/local/sbin/{{ file }}:
  file.managed:
    - source: salt:///usr/local/sbin/{{ file }}
    - mode: 755
{% endfor %}
