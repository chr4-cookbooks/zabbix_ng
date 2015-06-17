#
# Cookbook Name:: zabbix_ng
# Provider:: agent_ssl
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
  openssl_cmd = "/usr/bin/openssl x509 -enddate -noout -in #{new_resource.certificate}"

  # Monitor certificate
  zabbix_ng_agent_userparam new_resource.identifier do
    identifier new_resource.identifier
    command    %\expr $(expr $(date '+%s' --date "$(sudo #{openssl_cmd} |grep 'notAfter' |cut -d= -f2)") - $(date '+%s')) / 24 / 3600\
  end

  # Zabbix user needs access to certificate to check it
  sudo "zabbix_#{new_resource.identifier.tr_s('.', '_')}" do
    user     'zabbix'
    nopasswd true
    commands [openssl_cmd]
  end
end

action :delete do
  zabbix_ng_agent_userparam(new_resource.identifier) { action :delete }
  sudo("zabbix_#{new_resource.identifier}") { action :delete }
end
