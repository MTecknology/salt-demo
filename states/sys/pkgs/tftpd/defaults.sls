{% set conf = salt.grains.filter_by(
  {
    'default': {
      'source': None,
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('tftpd')
) %}
