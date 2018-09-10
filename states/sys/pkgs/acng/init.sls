acng:
  pkg.installed:
    - name: apt-cacher-ng
  service.running:
    - name: apt-cacher-ng
    - enable: True
    - require:
      - pkg: acng

{% for config in ['acng', 'security'] %}
/etc/apt-cacher-ng/{{ config }}.conf:
  file.managed:
    - source: salt://etc/apt-cacher-ng/{{ config }}.conf
    - template: jinja
    - require:
      - pkg: acng
    - require_in:
      - service: acng
    - listen_in:
      - service: acng
{% endfor %}
