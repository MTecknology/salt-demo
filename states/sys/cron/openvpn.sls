# A hack because of reconnect problems that haven't been fixed.
openvpn_pingcheck:
  cron.present:
    - identifier: openvpn_pingcheck
    - name: if ! ping -q -W 2 -c 1 10.41.7.1; then sleep 30; if ! ping -q -W 2 -c 1 10.41.7.1; then /usr/sbin/service openvpn restart; fi; fi >/dev/null
    - special: "@hourly"
