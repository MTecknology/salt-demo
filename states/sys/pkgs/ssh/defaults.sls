{% set conf = salt.grains.filter_by(
  {
    'default': {
      'allow_root': 'no',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('ssh')
) %}
