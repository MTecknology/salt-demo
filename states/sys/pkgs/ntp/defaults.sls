{% set conf = salt.grains.filter_by(
  {
    'default': {
      'server_list': [],
      'ntp_enabled': False,
      'timezone': 'Etc/UTC',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('ntp')
) %}
