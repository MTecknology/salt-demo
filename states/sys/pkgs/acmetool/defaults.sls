{% set conf = salt.grains.filter_by(
  {
    'default': {
      'domains': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('acmetool')
) %}
