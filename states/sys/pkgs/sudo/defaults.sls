{% set conf = salt.grains.filter_by(
  {
    'default': {
      'extra_conf': [],
      'extra_sbin': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('sudo')
) %}
