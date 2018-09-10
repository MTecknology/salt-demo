{% set conf = salt.grains.filter_by(
  {
    'default': {
      'sphinxconf': '',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('sphinxsearch')
) %}
