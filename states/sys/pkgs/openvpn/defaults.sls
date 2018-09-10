{% set conf = salt.grains.filter_by(
  {
    'default': {
      'groups': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('openvpn')
) %}
