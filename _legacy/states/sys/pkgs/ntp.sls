openntpd:
  pkg.purged

{% if salt['pillar.get']('ntp_enabled', False)%}
chronyd:
  pkg.installed:
    - name: chrony
  service.running:
    - name: chrony
    - watch:
      - file: /etc/chrony/chrony.conf

## files

/etc/chrony/chrony.conf:
  file.managed:
    - source: salt://etc/chrony/chrony.conf
    - require:
      - pkg: chronyd

{% else %}
chronyd:
  pkg.purged:
    - pkgs:
      - chronyd
      - chronyc

{% endif %}
