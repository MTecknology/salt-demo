#!jinja|yaml|gpg
include:
  - sys.base.users.root
  - sys.base.users.ssh_keys

admins:
  michael:
    uid: 1010
    gid: 1010
    pwd: '$6$...'
    gauth_key: '...'
    keys:
      - '...'
