{% set conf = salt.grains.filter_by(
  {
    'default': {
      'installs': []
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('pip-client')
) %}
