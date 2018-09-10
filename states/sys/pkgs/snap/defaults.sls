{% set conf = salt.grains.filter_by(
  {
    'default': {
      'excl': [],
      'incl': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('snap')
) %}
