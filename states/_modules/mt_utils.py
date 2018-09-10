#!/usr/bin/env python
'''
Helper functions for doing things.
Note(s):
- Name returns favor s/./_/ to prevent sls render errors.
'''
import re


def uuid(s):
    '''Returns a pseudo-unique ID for a passed string.'''
    if sys.version_info[0] < 3:
        return str(abs(zlib.crc32(s) & 0xffffffff))
    return str(abs(zlib.crc32(bytes(s, 'utf-8')) & 0xffffffff))


def parse_id(minion_id=None):
    '''
    Break a minion_id into components per naming convention:
      <service_level>-<application>[cluster_id]-<host_id>.<class>.<domain>.<tld>
    Using this function conveniently enforces a standardized naming convention. :)
    '''
    if not minion_id:
        minion_id = __grains__.get('id', '')
    node_r = re.compile('^(?P<sl>[a-z]+)-(?P<app>[a-z_]+)(?P<cid>[0-9]*)-(?P<hid>[0-9]+)\.'
                        '(?P<cls>.+?)\.(?P<dom>.+?)\.(?P<tld>.*)$')
    node = node_r.match(minion_id)
    if not node:
        return False
    return {
            'service_level': node.group('sl'),
            'cluster_name': node.group('app'),
            'cluster_member': bool(node.group('cid')),
            'cluster_id': node.group('cid') if node.group('cid') else '',
            'host_id': node.group('hid')}


def app_group_from_id(minion_id):
    '''Returns app group based on MTNet naming structure.
    >>> app_group_from_id('prd-ns-01.core.lusfield.net')
    prd_ns'''
    node = parse_id(minion_id)
    if not node:
        return False
    return '{}_{}{}'.format(
            node['service_level'],
            node['cluster_name'],
            node['cluster_id'])


def app_level_from_id(minion_id):
    '''Returns app level based on MTNet naming structure.
    >>> app_level_from_id('prd-ns-01.core.lusfield.net')
    prd'''
    node = parse_id(minion_id)
    if not node:
        return False
    return '{}'.format(node['service_level'])


def app_name_from_id(minion_id):
    '''Returns app level based on MTNet naming structure.
    >>> app_group_from_id('prd-ns-01.core.lusfield.net')
    ns'''
    node = parse_id(minion_id)
    if not node:
        return False
    return '{}{}'.format(node['cluster_name'], node['cluster_id'])


def sanitize_id(minion_id):
    '''Returns s/./_/ to prevent sls render errors.
    >>> minion_id = minion_id.replace('prd-ns-01.core.lusfield.net')
    prd-ns-01_core_lusfield_net'''
    return minion_id.replace('.', '_')
