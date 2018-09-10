{% if salt.match.glob('boot.domain.tld') %}
tftpd_source: boot
{% endif %}
