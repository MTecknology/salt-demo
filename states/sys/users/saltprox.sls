# Managed user allowing authentication to proxmox nodes.
saltstack-user:
  user.present:
    - name: saltstack
    - createhome: False
    - shell: /bin/nologin
    - password: '$6$ZxYrSRDE$At6IxmQPze6gV6nm1zZlvUM5FdKxGgzwsVkkipZRpfM7yWjJ/naN8rhYNOqZDhUYi/3/J6Q/IOlUOL8.SYf5u.'
