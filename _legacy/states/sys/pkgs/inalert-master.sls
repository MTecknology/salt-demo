mariadb-server:
  pkg.installed:
    - require:
      - debconf: mariadb-server
  debconf.set:
    - data:
        mysql-server/root_password: {'type': 'string', 'value': 'bRaT5QwgMELpF5'}
        mysql-server/root_password_again: {'type': 'string', 'value': 'bRaT5QwgMELpF5'}
