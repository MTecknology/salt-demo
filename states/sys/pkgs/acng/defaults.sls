{% set conf = salt.grains.filter_by(
  {
    'default': {
      'users': {},
      'remaps': {},
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('acng')
) %}
