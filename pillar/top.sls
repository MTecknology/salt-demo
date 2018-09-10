'base':
  '*':
    - sys.base
    - sys.pkgs
    - sys.remotes
  'prd-lb*.core.domain.tld':
    - cloud.profiles
  'prd-ns-*.core.domain.tld':
    - cloud.profiles
  'prd-salt-*.core.domain.tld':
    - cloud
