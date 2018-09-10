{% if salt.match.glob('endsalt.domain.tld') %}
salt:
  file_tag: endsalt
{% endif %}
