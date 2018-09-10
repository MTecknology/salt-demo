tor:
  pkg.installed:
    - name: tor
    - require_in:
      - file: /etc/ferm/ferm.conf
  service.running:
    - name: tor
    - enable: True

## files

/etc/tor/torsocks.conf:
  file.managed:
    - source: salt://etc/tor/torsocks.conf
    - watch_in:
      - service: tor
    - require:
      - pkg: tor

/etc/tor/torrc:
  file.managed:
    - source: salt://etc/tor/torrc
    - watch_in:
      - service: tor
    - require:
      - pkg: tor
