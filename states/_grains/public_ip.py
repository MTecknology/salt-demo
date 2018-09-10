#!/usr/bin/env python
'''
Attempts to track down the public IP address of the device.
Preference: ppp0; eth0; nill
'''

import salt.modules.network


def public_ip():
    '''Attempts to find public IP address'''
    # Get all IP addresses
    addrs = salt.modules.network.interfaces()
    
    if 'ppp0' in addrs:
        if addrs['ppp0']['up']:
            return _get_address(addrs['ppp0'])
        else:
            return {}
    elif 'eth0' in addrs:
        if addrs['eth0']['up']:
            return _get_address(addrs['eth0'])
        else:
            return {}

    ret = {}

def _get_address(addr):
    '''Attempts to retrieve a valid v4 and v6 public address'''
    ret = {}
    for net in ['inet', 'inet6']:
        if net in addr:
            for ipaddress in addr[net]:
                address = ipaddress['address']
                if address.startswith('10.'):
                    continue
                elif address.startswith('fe80:'):
                    continue
                elif address.startswith('169.'):
                    continue
                else:
                    if not 'public_ip' in ret:
                        ret['public_ip'] = {}
                    ret ['public_ip'][net] = address

    return ret
