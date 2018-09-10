{% if salt.match.glob('log.domain.tld') %}
syslog_conf: salt://etc/rsyslog/hosts.conf
{% else %}
syslog_conf: salt://etc/rsyslog/log.conf
{% endif %}
