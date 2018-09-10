#!/usr/bin/env python
##
# Helper functions for building unbound configs.
##


def zones_from_profiles(profiles={}, vlan=None, merge_devices='no'):
    '''Return a list of zones to create based on profile data.
    Exmaple return:
        'nodes':
            'prd-ns-01.core.domain.tld':
                'A': '1.2.3.4'
                'AAAA': '2004::3:4'
        'services':
            'prd-ns.core.domain.tld':
                'nodes':
                    - 'prd-ns-01.core.domain.tld'
                    - 'prd-ns-02.core.domain.tld'
                'address': '<haproxy address>'
        'aliases':
            'ns.domain.tld': 'prd-ns.core.domain.tld'''
    zones = {'nodes': {},
            'services': {},
            'aliases': {}}
    ip_addrs = __salt__['mt_netbox.run_query']('ipam/ip-addresses/?cf_lb_address=1')
    if not ip_addrs:
        return {}
    if not profiles:
        profiles = __salt__['pillar.get']('cloud:profiles', {})

    if merge_devices == 'yes':
        profiles = merge_profiles_with_devices(profiles, vlan)

    for profile, attr in sorted(profiles.items()):
        # Parse node data
        node = _parse_name(profile)
        if not node:
            continue
        for ipfam, ipcls in [('4', 'A'), ('6', 'AAAA')]:
            if attr.get('ipv{}addr'.format(ipfam), False):
                addr = _parse_address(attr.get('ipv{}addr'.format(ipfam), None), ipcls)
                if not addr:
                    continue
                if vlan is None or str(vlan) == str(addr['vlan_tag']):
                    if not node['fqdn'] in zones['nodes']:
                        zones['nodes'][node['fqdn']] = {}
                    zones['nodes'][node['fqdn']][ipcls] = addr

        # Include node app in services list
        service = '{}.{}.{}'.format(node['app_group'], node['subdomain'], node['root_domain'])
        for ipfam, ipcls in [('4', 'A'), ('6', 'AAAA')]:
            service_addr = _get_service_addr(ip_addrs, service, ipfam)
            if not service_addr:
                continue
            addr = _parse_address(service_addr['address'], ipcls)
            if not addr:
                continue
            if not service in zones['services']:
                if vlan is None or str(vlan) == str(addr['vlan_tag']):
                    # services.$svc
                    zones['services'][service] = {'nodes': [], 'address': {}}
                else:
                    continue
            # services.$svc.nodes
            if node['fqdn'] not in zones['services'][service]['nodes']:
                zones['services'][service]['nodes'].append(node['fqdn'])
            # services.$svc.address.$class
            if ipcls not in zones['services'][service]['address']:
                zones['services'][service]['address'][ipcls] = addr
            # services.$svc.address.$class.lb_sockets
            lb_sockets = service_addr['custom_fields'].get('lb_sockets', False)
            if lb_sockets is not None and lb_sockets:
                if 'lb_sockets' not in zones['services'][service]['address'][ipcls]:
                    zones['services'][service]['address'][ipcls]['lb_sockets'] = lb_sockets.split(',')
                if not 'lb_protos' in zones['services'][service]['address'][ipcls]:
                    zones['services'][service]['address'][ipcls]['lb_protos'] = []
                if not 'lb_ports' in zones['services'][service]['address'][ipcls]:
                    zones['services'][service]['address'][ipcls]['lb_ports'] = []
                for socket in lb_sockets.split(','):
                    proto, port = socket.split('/')
                    if proto not in zones['services'][service]['address'][ipcls]['lb_protos']:
                        zones['services'][service]['address'][ipcls]['lb_protos'].append(proto)
                    if port not in zones['services'][service]['address'][ipcls]['lb_ports']:
                        zones['services'][service]['address'][ipcls]['lb_ports'].append(port)

        # Core Production services are given "naked" service addresses
        if not service in zones['services']:
            continue
        if node['service_level'] == 'prd' and node['subdomain'] in ['core']:
            service_alias = '{}.{}'.format(node['application'], node['root_domain'])
            zones['aliases'][service_alias] = service

    # For VM w/ dns_alias defined
    machines = __salt__['mt_netbox.run_query']('virtualization/virtual-machines')
    if not machines['results']:
        return zones
    for vm in machines['results']:
        aliases = vm['custom_fields'].get('dns_alias', None)
        if aliases is not None and aliases:
            for alias in aliases.split(','):
                if not alias in zones['aliases']:
                    zones['aliases'][alias] = vm['name']

    return zones


def merge_profiles_with_devices(profiles, vlan=None):
    '''Merge devices into profiles dictionary.'''
    # site_id=3 == proxint
    devices = __salt__['mt_netbox.run_query']('dcim/devices/?site_id=3')
    if not devices:
        return {}
    for dev in devices['results']:
        profile_name = 'proxint_{}'.format(dev['name'])
        for ipver, ipcls in [('4', 'A'), ('6', 'AAAA')]:
            if dev['primary_ip{}'.format(ipver)]:
                addr = _parse_address(dev['primary_ip{}'.format(ipver)]['address'], ipcls)
                if vlan is None or str(vlan) == str(addr['vlan_tag']):
                    if profile_name not in profiles:
                        profiles[profile_name] = {'name': dev['name']}
                    profiles[profile_name]['ipv{}addr'.format(ipver)] = dev['primary_ip{}'.format(ipver)]['address']
    return profiles


def check_upstream_list(zones, service, port, ipclass):
    '''Checks that an nginx (LB) "upstream" block will not be empty.'''
    for node in zones['services'][service].get('nodes', []):
        if ipclass in zones['nodes'].get(node, {}):
            return True
    return False


def ipfmt(ipaddr, ipclass='A'):
    '''Quick function to wrap an IPv6 addresses in brackets.'''
    if ipclass == 'AAAA':
        return '[{}]'.format(ipaddr)
    return ipaddr


def _get_service_addr(addresses, service, addr_fam):
    '''Returns an haproxy address for a service, if one exists.'''
    for addr in addresses.get('results', []):
        desc = addr.get('description', '')
        if desc == service and addr_fam == str(addr.get('family', 'x')):
            return addr
    return False


def _parse_name(profile_name):
    '''Disect the profile name into helpful bits.'''
    try:
        vps_provider, fqdn = profile_name.split('_')
        node, subdom, domain, tld = fqdn.split('.')
        svclvl, app, node_id = node.split('-')
    except:
        # Ignore parse errors, not everything will match
        return False
    return {'vps_provider': vps_provider,
            'fqdn': fqdn,
            'node_name': node,
            'subdomain': subdom,
            'root_domain': '{}.{}'.format(domain, tld),
            'service_level': svclvl,
            'application': app,
            'node_id': node_id,
            'app_group': '{}-{}'.format(svclvl, app)}

def _parse_address(address, cls='A'):
    '''Disect the different components of an IP address.'''
    if not address or address is None:
        return False
    try:
        if cls == 'A':
            return {
                    'addr': address.split('/')[0],
                    'cidr': address.split('/')[1],
                    'vlan_tag': address.split('.')[2]}
        if cls == 'AAAA':
            return {
                    'addr': address.split('/')[0],
                    'cidr': address.split('/')[1],
                    'vlan_tag': address.split(':')[3]}
    except:
        pass
    return False
