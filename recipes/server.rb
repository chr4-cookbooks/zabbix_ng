#
# Cookbook Name:: zabbix_ng
# Recipe:: server
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

package 'zabbix-server-pgsql'
package 'zabbix-frontend-php'

service 'zabbix-server' do
  action :enable
end

template '/etc/zabbix/zabbix_server.conf' do
  mode     00644
  source   'server/zabbix_server.conf.erb'
  variables logfile: '/var/log/zabbix/zabbix_server.log',
            pidfile: '/var/run/zabbix/zabbix_server.pid',
            db_host: '/var/run/postgresql',
            db_name: 'zabbix',
            db_user: 'zabbix'

  notifies  :restart, 'service[zabbix-server]'
end
