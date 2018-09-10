{% set conf = salt.grains.filter_by(
  {
    'default': {
      'rules': [],
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('udev')
) %}
