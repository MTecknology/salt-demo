{% set conf = salt.grains.filter_by(
  {
    'default': {
      'null_ok': False,
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('gauth')
) %}
