#
# Cookbook Name:: zabbix_ng
# Recipe:: agent
#
# Copyright (C) 2015 Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe 'zabbix_ng::repository'

package 'zabbix-agent'

template '/etc/zabbix/zabbix_agentd.conf' do
  mode      00644
  source    'agent/zabbix_agentd.conf.erb'
  variables zabbix_server: node['zabbix_ng']['zabbix_server']
end

# Include package manager specific update checks
case node['platform_family']
when 'debian'
  # aptitude is required to get available update count
  package 'aptitude'

  template '/etc/zabbix/zabbix_agentd.d/apt.conf' do
    owner    'root'
    group    'root'
    mode     00644
    cookbook 'zabbix_ng'
    source   'agent/apt.conf.erb'
  end

when 'rhel', 'fedora'
  # TODO: yum repository is currently not supported anyway
  template '/etc/zabbix/zabbix_agentd.d/yum.conf' do
    owner    'root'
    group    'root'
    mode     00644
    cookbook 'zabbix_ng'
    source   'agent/yum.conf.erb'
  end
end

service 'zabbix-agent' do
  case node['platform_family']
  when 'debian'
    subscribes :restart, 'template[/etc/zabbix/zabbix_agentd.d/yum.conf]'
  when 'rhel', 'fedora'
    subscribes :restart, 'template[/etc/zabbix/zabbix_agentd.d/apt.conf]'
  end

  subscribes :restart, 'template[/etc/zabbix/zabbix_agentd.conf'

  action [:enable, :start]
end

