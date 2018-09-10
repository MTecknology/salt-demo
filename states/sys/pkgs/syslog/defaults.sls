{% set conf = salt.grains.filter_by(
  {
    'default': {
      'logconf': 'nil',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('syslog')
) %}
