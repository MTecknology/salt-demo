/etc/resolv.conf:
  file.managed:
    - contents: |
        nameserver 10.2.2.1
        nameserver 10.2.2.2
        nameserver 9.9.9.9
        search domain.tld
