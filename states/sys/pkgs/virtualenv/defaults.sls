{% set conf = salt.grains.filter_by(
  {
    'default': {
      'virtualenvs': {},
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('virtualenv')
) %}
