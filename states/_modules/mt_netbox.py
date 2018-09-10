#!/usr/bin/env python
##
# Module to query the netbox api and assemble a cloud nodes list.
# Depends: python-netaddr
#  NOTE: This dependency can be dropped in python-3.x.
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
    r = run_query('virtualization/virtual-machines')
    if not r:
        return None

    nodes = {}
    for node in r['results']:
        colo = node['cluster']['name']
        if colo == 'proxint':
            n = _parse_proxint(node)
        elif colo.startswith('do-'):
            n = _parse_digitalocean(node)
        elif colo.startswith('aws-'):
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


def run_query(query):
    url = __opts__['netbox_api_url'] + query
    try:
        response = urllib.urlopen(url)
        return json.loads(response.read())
    except:
        return False


def _parse_proxint(node):
    attr = {'type': 'lxc',
            'iface': {'net0': {'name': 'eth0'}}}
    vlan = False

    if not node.get('primary_ip4', None):
        return None

    if node['custom_fields'].get('proxint_storage', False):
        attr['storage'] = str(node['custom_fields']['proxint_storage']['label'])
    attr['cpu'] = node.get('vcpus', '2')
    attr['mem'] = node.get('memory', '512')
    attr['disk_size'] = node.get('disk_size', '8')

    for ipver in ['4', '6']:
        if 'primary_ip{}'.format(ipver) in node and node['primary_ip{}'.format(ipver)] is not None:
            ipaddr = str(node['primary_ip{}'.format(ipver)].get('address', None))
            if ipaddr is None or not ipaddr:
                continue
            gwaddr = str(netaddr.IPNetwork(ipaddr)[1])
            if ipver == '4':
                vlan = str(ipaddr.split('.')[2])
            elif ipver == '6':
                vlan = str(ipaddr.split(':')[3])
            attr['iface']['net0']['ipv{}_addr'.format(ipver)] = ipaddr
            attr['iface']['net0']['ipv{}_gw'.format(ipver)] = gwaddr

    if vlan:
        attr['iface']['net0']['vlan'] = vlan

    return {'bucket': 'proxint-nodes',
            'node_name': node['name'],
            'node_data': attr}


def _parse_digitalocean(node):
    attr = {}
    if node.get('memory', None):
        attr['size'] = str(node['memory']) + 'MB'
    if node['custom_fields'].get('DO_Image', None):
        attr['image'] = str(node['custom_fields']['DO_Image']['label'].split('|')[1].strip())

    site = node['cluster']['name']
    if site == 'do-nyc3':
        attr['location'] = 'New York 3'
    elif site == 'do-sfo2':
        attr['location'] = 'San Francisco 2'

    return {'bucket': 'do-nodes',
            'node_name': node['name'],
            'node_data': attr}


def _parse_amazonwebsvc(node):
    attr = {}
    return {'bucket': 'amazonwebsvc-nodes',
            'node_name': node['name'],
            'node_data': attr}
