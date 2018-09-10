#!jinja|yaml|gpg
cloud:
  providers:
    digitalocean:
      driver: digital_ocean
      private_networking: False
      ipv6: True
      script: ovpn_deploy
      creat_dns_record: False
      personal_access_token: |
          -----BEGIN PGP MESSAGE-----

          e5IAK5OaRPAviUrW6rH9egl6circwuqPjB4h9y+2vnoH64jJBEw60CKKAahi2rng
          WseZ+o2hip24fIwQeiQGJOAlbTvSS517pUk4WUMGABpUO+ZLLQOU5ztnvEF0oczU
          tEqQuOQLvisnmEoJ1SJC3lx1JebWgZo6j9UKBaq4nUkZYH0NC/QB9N6hCIMczXWF
          igXKubDpl+ATLJ2TotbbtlLMeGZAgyPH/2jZmaZyM5rQrbrfD/HAb4mbC1heKRR3
          H4soIUM9YhcDMwX9ZD09Jo7ypfoAjRsp5/d3/kQh8WNQAEk42dMxxDjo06k8kW53
          WseZ+o2hip24fIwQeiQGJOAlbTvSS517pUk4WUMGABpUO+ZLLQOU5ztnvEF0oczU
          PJBZcYM3KsvFTnGMASpX+M+SYEfbcTjjoYDAncjtT6MuIUkG65GlCd2WmoM0AyTS
          cwF3Bpk/IQbY5wtER8M1g7TYVaDy3U5k8xr0E1VuUM9jlk/NHraXUHMSbQd1YMkl
          q80guCyqSka91YXwsirKSukUG+uKgmzLk8t6szU0PuAGf3cNgtzRm4EIul+8s0zo
          -----END PGP MESSAGE-----
