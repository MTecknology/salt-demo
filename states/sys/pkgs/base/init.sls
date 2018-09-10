base_pkgs:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - file
      - lsof
      - net-tools
      - screen
      - vim

base_pkgs_removed:
  pkg.purged:
    - pkgs:
      - apt-listchanges
      - dhcpcd5
