timezone: Etc/UTC

{% if salt.match.glob('virt*') %}
ntp_enabled: True

{% elif salt.match.glob('arn*') %}
ntp_enabled: True

{% elif salt.match.grain('virtual:kvm') %}
ntp_enabled: True

{% else %}
ntp_enabled: False

{% endif %}
