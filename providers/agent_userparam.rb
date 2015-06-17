#
# Cookbook Name:: zabbix_ng
# Provider:: agent_userparam
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

use_inline_resources

action :create do
  # Unless variables is set, use identifier + command
  variables = new_resource.variables ||
              { identifier: new_resource.identifier,
                command: new_resource.command }

  template new_resource.name do
    owner     'root'
    group     'root'
    mode      00644
    path      "/etc/zabbix/zabbix_agentd.d/userparameter_#{new_resource.name}.conf"
    cookbook  new_resource.cookbook
    source    new_resource.source
    variables variables
    action    :create
  end

  service 'zabbix-agent' do
    supports   status: true, restart: true
    action     :nothing
    subscribes :restart, resources("template[#{new_resource.name}]")
  end
end

action :delete do
  file new_resource.name do
    path   "/etc/zabbix/zabbix_agentd.d/userparameter_#{new_resource.name}.conf"
    action :delete
  end

  service 'zabbix-agent' do
    supports   restart: true
    action     :nothing
    subscribes :restart, resources("file[#{new_resource.name}]")
  end
end
