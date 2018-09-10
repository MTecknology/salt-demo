#!/usr/bin/env python
##
# Author:      Michael Lustfield (MTecknology)
# License:     CC BY-NC-ND 4.0
#              https://creativecommons.org/licenses/by-nc-nd/4.0/
# Depends:     python-netaddr            # can be dropped in python-3.x
# Description: This module is used to query the NetBox API and assemble
#              a dictionary of inventory.
##

import json
import urllib
import sys
try:
    import netaddr
except:
    pass


def __virtual__():
    '''Only load if we have authentication'''
    if 'netaddr' not in sys.modules:
        return (False, 'Package python-netaddr is not available.')

    if 'netbox_api_url' not in __opts__:
        return (False, 'Configuration options not found.')

    return True


def get_nodes():
    '''Returns big data for pillar construction.'''
    r = _run_query('dcim/devices')
    if not r:
        return None

    nodes = {}
    for node in r['results']:
        if not node['device_role']['slug'] == 'vps':
            continue
        if node['site']['slug'] == 'proxint':
            n = _parse_proxint(node)
        elif node['site']['slug'].startswith('do-'):
            n = _parse_digitalocean(node)
        elif node['site']['slug'].startswith('aws-'):
            n = _parse_amazonwebsvc(node)
        else:
            continue
        if n:
            if not n['bucket'] in nodes:
                nodes[str(n['bucket'])] = {}
            if n['node_name'] in nodes[n['bucket']].keys():
                #TODO: Salt error
                print('Duplicate node detected: {}'.format(n['node_name']))
            nodes[n['bucket']][str(n['node_name'])] = n['node_data']

    return nodes


def _run_query(query):
    url = __opts__['netbox_api_url'] + query
    try:
        response = urllib.urlopen(url)
        return json.loads(response.read())
    except:
        #TODO: Salt warning
        return None


def _parse_proxint(node):
    attr = {'type': str(node['device_type']['slug']),
            'iface': {'net0': {'name': 'eth0'}}}

    if attr['type'] not in ['lxc', 'kvm']:
        return None
    if not node.get('primary_ip4', None):
        return None

    if node['custom_fields'].get('PI_Host', None):
        attr['host']      = str(node['custom_fields']['PI_Host'])
    if node['custom_fields'].get('PI_CPU', None):
        attr['cpu']       = str(node['custom_fields']['PI_CPU'])
    if node['custom_fields'].get('PI_Size', None):
        attr['disk_size'] = str(node['custom_fields']['PI_Size'])
    if node['custom_fields'].get('PI_Mem', None):
        attr['mem']       = str(node['custom_fields']['PI_Mem'])
    if node['custom_fields'].get('PI_Image', None):
        attr['image']     = str(node['custom_fields']['PI_Image']['label'])
    if node['custom_fields'].get('PI_Storage', None):
        attr['storage']   = str(node['custom_fields']['PI_Storage']['label'])
    if node['custom_fields'].get('PI_OnBoot', None):
        attr['onboot']    = str(node['custom_fields']['PI_OnBoot'])
    if node['custom_fields'].get('PI_Swap', None):
        attr['swap']      = str(node['custom_fields']['PI_Swap'])

    v4ip = str(node['primary_ip4']['address'])
    v4gw = str(netaddr.IPNetwork(v4ip)[1])
    vlan = str(node['primary_ip4']['address'].split('.')[2])
    attr['iface']['net0']['ipv4_addr'] = v4ip
    attr['iface']['net0']['ipv4_gw']   = v4gw
    attr['iface']['net0']['vlan']      = vlan

    if node.get('primary_ip6', None):
        v6ip = str(node['primary_ip6']['address'])
        v6gw = str(netaddr.IPNetwork(v4ip)[1])
        attr['iface']['net0']['ipv6_addr'] = v6ip
        attr['iface']['net0']['ipv6_gw']   = v6gw

    return {'bucket': 'proxint-nodes',
            'node_name': node['name'],
            'node_data': attr}


def _parse_digitalocean(node):
    attr = {}
    if node['custom_fields'].get('DO_Size', None):
        attr['size']      = str(node['custom_fields']['DO_Size']['label'])
    if node['custom_fields'].get('DO_Image', None):
        attr['image']     = str(node['custom_fields']['DO_Image']['label'].split('|')[1].strip())
    if node['custom_fields'].get('DO_Location', None):
        attr['location']  = str(node['custom_fields']['DO_Location'])

    site = str(node['site']['slug'])
    if site == 'do-nyc3':
        attr['location'] = 'New York 3'
    elif site == 'do-sfo2':
        attr['location'] = 'San Fransisco 2'

    return {'bucket': 'digitalocean-nodes',
            'node_name': node['name'],
            'node_data': attr}


def _parse_amazonwebsvc(node):
    attr = {}
    return {'bucket': 'amazonwebsvc-nodes',
            'node_name': node['name'],
            'node_data': attr}
