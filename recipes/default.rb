#
# Cookbook:: confluent
# Recipe:: default
#
# Copyright:: 2017, Jeremy Custenborder
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
  when 'debian'
    apt_repository 'confluent' do
      uri node['confluent']['repository_url']
      key node['confluent']['key_url']
      distribution 'stable'
      components ['main']
      arch 'amd64'
    end if node['confluent']['manage_repo']
  when 'rhel'
    yum_repository 'Confluent' do
      description 'Confluent repository'
      baseurl node['confluent']['repository_url']
      gpgkey node['confluent']['key_url']
      gpgcheck node['confluent']['gpg_check']
      enabled node['confluent']['repo_enabled']
    end

    yum_repository 'Confluent.dist' do
      description 'Confluent repository (dist)'
      baseurl node['confluent']['dist_repository_url']
      gpgkey node['confluent']['key_url']
      gpgcheck node['confluent']['gpg_check']
      enabled node['confluent']['repo_enabled']
    end
end

package 'confluent-platform' do # ~FC009 only available in apt_package. See #388
  package_name node['confluent']['package']
end

execute 'systemctl-daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end