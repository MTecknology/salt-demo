{% set conf = salt.grains.filter_by(
  {
    'default': {
      'sites': [],
      'dirs': [],
      'site-links': {},
      'webcerts': {},
      'with_lb': False,
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('nginx')
) %}
