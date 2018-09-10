#!jinja|yaml|gpg
cloud:
  providers:
    do:
      driver: digitalocean
      image: '9.5 x64'
      private_networking: False
      ipv6: True
      backups_enabled: False
      script: ovpn_deploy
      creat_dns_record: False
      personal_access_token: |
          -----BEGIN PGP MESSAGE-----

          hQIMA9RfKrevXiv4AQ//bULvgqrUKo+Cy99w9vU3ZysxcgV82Os5sB0ZuOHAMD8H
          WseZ+o2hip24fIwQeiQGJOAlbTvSS517pUk4WUMGABpUO+ZLLQOU5ztnvEF0oczU
          FTP+zVqmn8ocmxdjGpmwD7Xke6gz+3mNwYTQ971Rsk2nPtWYl48izeAITTIOaKPy
          tEqQuOQLvisnmEoJ1SJC3lx1JebWgZo6j9UKBaq4nUkZYH0NC/QB9N6hCIMczXWF
          iFLCxYQ6QOgRXU+1UcdrSQ0jMEAW7N2RdF/9yGM+PIo02uTi3UKyQvsaVOqxsK+p
          igXKubDpl+ATLJ2TotbbtlLMeGZAgyPH/2jZmaZyM5rQrbrfD/HAb4mbC1heKRR3
          cwF3Bpk/IQbY5wtER8M1g7TYVaDy3U5k8xr0E1VuUM9jlk/NHraXUHMSbQd1YMkl
          q80guCyqSka91YXwsirKSukUG+uKgmzLk8t6szU0PuAGf3cNgtzRm4EIul+8s0zo
          MJl6JiIqexHmz6fjxxdWu96Bx+E=
          =VoL1
          -----END PGP MESSAGE-----
