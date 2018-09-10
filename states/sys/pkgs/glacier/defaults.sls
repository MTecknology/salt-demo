{% set conf = salt.grains.filter_by(
  {
    'default': {
      'aws_access': '',
      'aws_secret': '',
      'aws_region': '',
      'encrypt_recipient': '',
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('glacier')
) %}
