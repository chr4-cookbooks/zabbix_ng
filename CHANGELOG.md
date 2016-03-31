# 1.0.1

- Use `node['fqdn']` as the default hostname in `zabbix_agentd.conf`. This resolves issues with zabbix-trapper when using `zabbix_sender`

# 1.0.0

- Introduce new parameter `node['zabbix_ng']['zabbix_version']`
- Update default zabbix version to `3.0`
- NOTE: In case you want to stay with zabbix-2.4, make sure to set the following attribute:
  `default['zabbix_ng']['zabbix_version'] = '2.4'`

# 0.1.1

- Restart zabbix agent after config file was deployed
- Intrudoce attribute to set zabbix agent timeout


# 0.1.0

- Initial release of zabbix\_ng
