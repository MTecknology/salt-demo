{% set conf = salt.grains.filter_by(
  {
    'default': {
      'grants': {},
      'users': {},
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('postgresql')
) %}
