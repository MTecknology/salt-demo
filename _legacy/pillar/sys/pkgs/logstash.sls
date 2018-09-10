{% if salt.match.glob('itel*') %}
logstash:
    configs: [ 'itel.conf' ]
    templates: [ 'itel.json' ]
    patterns: [ 'itel' ]
    imap_user: "rdata@gmail.com"
    imap_pass: gpg_blob
{% endif %}
