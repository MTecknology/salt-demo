unbound:
  pkg.installed:
    - name: unbound
  service.running:
    - require:
      - pkg: unbound

# useful for local debugging
dnsutils:
  pkg.installed

/etc/unbound/unbound.conf.d/unbound.conf:
  file.managed:
    - source: salt://etc/unbound/unbound.conf.d/unbound.conf
    - watch_in:
      - service: unbound

/etc/unbound/unbound.conf.d/zones.conf:
  file.managed:
    - source: salt://etc/unbound/unbound.conf.d/zones.conf
    - template: jinja
    - watch_in:
      - service: unbound
