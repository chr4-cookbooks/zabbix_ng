# Description

This cookbook installs and configures zabbix

# Attributes

Set the zabbix server

```ruby
node['zabbix_ng']['agent']['zabbix_server'] # defaults to '127.0.0.1'
```

# Recipes

## agent

Installs zabbix-agent, adds package-manager specific update monitoring

Adds the following UserParameters, that return the amount of upgradeable packages

```ruby
apt.updates # for debian and ubuntu
yum.updates # for scientific, redhat, centos and fedora
```

## server

Installs zabbix-server

# Providers

To use the providers, make sure you add the following line to your metadata.rb

```ruby
depends 'zabbix'
```

## zabbix\_agent\_userparam

This LRWP can be used to maintain zabbix user parameters in the zabbix_agentd.d directory.

Create a new rule like this

```ruby
zabbix_ng_agent_userparam 'thin' do
  identifier 'my.zabbix_identifier'
  command    'my_zabbix_command --with --arguments'
end
```

You can also use your own templates

```ruby
zabbix_ng_agent_userparam 'postgresql' do
  cookbook 'flinc-database'
  source   'zabbix_parameters_postgresql.erb'
  variables :my => 'var'
end
```


## zabbix\_agent\_ssl

This LWRP monitores the SSL expiration date

```ruby
zabbix_ng_agent_ssl '/etc/nginx/certs/server.crt'
```

You can also specify a custom zabbix identifier (defaults to ssl.certificate)

```ruby
zabbixng__agent_ssl 'my custom certificate monitoring' do
  certificate '/etc/ssl/mycert.pem'
  identifier  'custom.zabbix_identifier'
end
```
