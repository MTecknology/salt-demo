{% set conf = salt.grains.filter_by(
  {
    'default': {
      'additional_rules': {
        'inbound': [],
        'outbound': [],
        'forward': [],
      },
      'knock_sequence': {},
    },
  },
  grain = 'os_family',
  merge = salt.pillar.get('ferm')
) %}

{% set service_map = [
  {'package': 'nginx-common',
   'rules': ['proto tcp dport (http https) ACCEPT']},
  {'package': 'plexmediaserver',
   'rules': [
     'proto tcp dport (32400) ACCEPT',
     'proto tcp dport (5050 8080) ACCEPT']},
  {'package': 'postfix',
   'rules': ['proto tcp dport (25) ACCEPT']},
  {'package': 'proxmox-ve',
   'rules': [
     'proto tcp dport (8006 5900:5999 3128 111) ACCEPT',
     'proto udp dport (5404:5405) ACCEPT']},
  {'package': 'salt-master',
   'rules': ['proto tcp dport (4505 4506) ACCEPT']},
  {'package': 'sshguard',
   'rules': ['jump sshguard']},
  {'package': 'tftpd-hpa',
   'rules': ['proto (tcp udp) dport 69 ACCEPT']},
  {'package': 'unifi',
   'rules': [
     'proto tcp dport (8080 8880 8843 8443) ACCEPT',
     'proto udp dport (3478 10001) ACCEPT']},
  {'package': 'unbound',
   'rules': ['proto (tcp udp) dport 53 ACCEPT']},
] %}

#  {'package': '',
#   'rules': ['']},
