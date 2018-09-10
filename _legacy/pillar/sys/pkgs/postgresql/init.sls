include:
  - sys.pkgs.postgresql.{{ grains['id'].replace('.', '_') }}
