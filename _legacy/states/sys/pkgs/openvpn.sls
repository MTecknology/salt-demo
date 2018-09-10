openvpn:
  pkg.installed:
    - name: openvpn
  service.running:
    - enable: True
    - require:
      - pkg: openvpn

## files

/etc/openvpn/update-resolv:
  file.managed:
    - source: salt://etc/openvpn/update-resolv
    - mode: 750

{% for _, group in salt['pillar.get']('openvpn:groups', []).items() %}
/etc/openvpn/{{ group['name'] }}.conf:
  file.managed:
    - source: salt://etc/openvpn/{{ group['role'] }}.jinja
    - template: jinja
    - context:
        netid: {{ group['name'] }}
    - mode: 750
    - watch_in:
      - service: openvpn

/etc/openvpn/{{ group['name'] }}.pem:
  file.managed:
    - contents_pillar: openvpn:groups:{{ group['name'] }}:dh_params

{% if group['role'] == 'client' %}
{% for address in salt['mine.get'](group['upstream'], 'network.ip_addrs')[group['upstream']] %}
{% if '10.' not in address and '172.' not in address %}
route_{{ group['name'] }}_upstream:
  cmd.run:
    - name: "/sbin/ip route add '{{ address }}' dev eth1"
    - unless: "/sbin/ip route show dev eth1 | grep -q '{{ address }}'"
    - watch_in:
      - service: openvpn
{% endif %}
{% endfor %}

{% elif group['role'] == 'server' %}
/etc/salt/minion.d/openvpn.conf:
  file.managed:
    - contents: |
        mine_functions:
          network.ip_addrs: [eth0]
    - watch_in:
      - service: salt-minion
{% endif %}

{% endfor %}
