{% set conf = salt.grains.filter_by(
  {
    'default': {
      'user': '',
      'pass': '',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('ssmtp')
) %}
