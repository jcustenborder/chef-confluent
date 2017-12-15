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
=begin
#<
This recipe is used to install the Confluent YUM or APT repositories and the installation package for the Confluent
Platform.

@section Examples

#### Standard installation

```json
{
  "run_list": [
    "recipe[confluent::default]"
  ]
}
```

#### Internal repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::default]"
  ]
}
#>
=end
case node['platform_family']
  when 'debian'
    apt_repository 'confluent' do
      uri node['confluent']['apt_repository_url']
      key node['confluent']['apt_key_url']
      distribution 'stable'
      components ['main']
      arch 'amd64'
    end if node['confluent']['manage_repo']
  when 'rhel'
    yum_repository 'Confluent' do
      description 'Confluent repository'
      baseurl node['confluent']['yum_repository_url']
      gpgkey node['confluent']['yum_key_url']
      gpgcheck node['confluent']['gpg_check']
      enabled node['confluent']['repo_enabled']
    end

    yum_repository 'Confluent.dist' do
      description 'Confluent repository (dist)'
      baseurl node['confluent']['yum_dist_repository_url']
      gpgkey node['confluent']['yum_key_url']
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