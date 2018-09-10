{% if not grains['id'].startswith('inalert') %}
ssmtp:
  pkg.installed
{% endif %}

## files

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://etc/ssmtp/ssmtp.conf
    - template: jinja
    - require:
      - pkg: ssmtp
