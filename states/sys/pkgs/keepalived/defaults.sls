{% set conf = salt.grains.filter_by(
  {
    'default': {
      'vlan': '',
      'router_id': 0,
      'authpass': '',
      'iface': 'eth0',
      'notify_addr': '',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('keepalived')
) %}
