git.domain.tld:
  ssh_known_hosts.present:
    - user: root
    - enc: ecdsa
    - fingerprint: 6a:50:b6:45:6d:e9:14:43:96:16:12:3b:57:b6:72:c0

git-client:
  pkg.installed:
    - pkgs:
      - git
      - python-git
    - require:
      - ssh_known_hosts: git.domain.tld
