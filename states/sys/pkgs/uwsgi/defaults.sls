{% set conf = salt.grains.filter_by(
  {
    'default': {
      'apps': [],
      'deps': [],
      'app-links': {},
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('uwsgi')
) %}
