www-data:
  user.present:
    - name: www-data
    - uid: 33
    - gid: 33
    - groups:
      - www-data
    - home: /var/www
    - shell: /bin/sh
    - require:
      - group: www-data
      - file: /var/www
  group.present:
    - name: www-data
    - gid: 33

/var/www:
  file:
    - directory

/var/www/.gpg:
  file.directory:
    - user: www-data
    - group: www-data
    - dir_mode: 700
    - require:
      - user: www-data
      - group: www-data
      - file: /var/www
