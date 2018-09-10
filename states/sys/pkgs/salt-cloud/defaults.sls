{% set conf = salt.grains.filter_by(
  {
    'default': {
      'netbox_api_url': 'nil',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('salt-cloud')
) %}
