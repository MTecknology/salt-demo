ferm:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/ferm/ferm.conf
    - require:
      - pkg: ferm
    - sig: init
    - order: last

## files

/etc/ferm/ferm.conf:
  file.managed:
    - source: salt://etc/ferm/ferm.conf
    - template: jinja
    - order: last
    - context:
        ferm_rules: {{ pillar.get('ferm_rules', {}) }}
        knock: {{ pillar.get('knock_sequence', None) }}
