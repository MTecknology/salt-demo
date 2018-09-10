{% from 'sys/pkgs/ntp/defaults.sls' import conf with context -%}
openntpd:
  pkg.purged

{% if conf['ntp_enabled'] or
      salt.match.grain('virtual:kvm') %}
chronyd:
  pkg.installed:
    - name: chrony
  service.running:
    - name: chrony
    - watch:
      - file: chronyd
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://etc/chrony/chrony.conf
    - template: jinja
    - require:
      - pkg: chronyd

{% else %}
chronyd:
  pkg.purged:
    - pkgs:
      - chronyd
      - chronyc

{% endif %}
