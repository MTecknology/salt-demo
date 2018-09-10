{% set conf = salt.grains.filter_by(
  {
    'default': {
      'file_tag': 'nil',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('salt-master')
) %}
