{% set conf = salt.grains.filter_by(
  {
    'default': {
      'zones': [],
      'blacklist': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('unbound')
) %}
