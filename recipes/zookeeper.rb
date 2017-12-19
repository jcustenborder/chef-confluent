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
This recipe is used to install an Apache Zookeeper server using the Confluent installation packages.

@section Examples

#### Standard installation

```json
{
  "confluent": {
    "zookeeper": {
      "myid": 1,
      "config": {
        "server.1": "zookeeper-01:2888:3888",
        "server.2": "zookeeper-02:2888:3888",
        "server.3": "zookeeper-03:2888:3888"
      }
    }
  },
  "run_list": [
    "recipe[confluent::zookeeper]"
  ]
}
```

#### Internal Repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "zookeeper": {
      "myid": 1,
      "config": {
        "server.1": "zookeeper-01:2888:3888",
        "server.2": "zookeeper-02:2888:3888",
        "server.3": "zookeeper-03:2888:3888"
      }
    },
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::zookeeper]"
  ]
}
```
#>
=end

require 'chef/application'

include_recipe('confluent::default')

unless node['confluent']['zookeeper']['my_id']
  Chef::Application.fatal!("['confluent']['zookeeper']['my_id'] must be specified.")
end

user node['confluent']['zookeeper']['user'] do
  comment 'Service Account for Zookeeper'
  system true
end

directory node['confluent']['zookeeper']['log_dir'] do
  owner node['confluent']['zookeeper']['user']
  group node['confluent']['zookeeper']['user']
  mode node['confluent']['zookeeper']['log_dir_mode']
  recursive true
end

directory node['confluent']['zookeeper']['data_dir'] do
  owner node['confluent']['zookeeper']['user']
  group node['confluent']['zookeeper']['user']
  mode node['confluent']['zookeeper']['data_dir_mode']
  recursive true
end

myid_path = File.join(node['confluent']['zookeeper']['data_dir'].to_s, 'myid')

template myid_path do
  owner node['confluent']['zookeeper']['user']
  group node['confluent']['zookeeper']['user']
  mode '0644'
  source 'zookeeper/myid.erb'
  notifies :restart, "service[#{node['confluent']['zookeeper']['service']}]", :delayed
end


template node['confluent']['zookeeper']['config_file'] do
  owner node['confluent']['zookeeper']['config_file_owner']
  group 'root'
  mode node['confluent']['zookeeper']['config_file_mode']
  source 'zookeeper/zookeeper.properties.erb'
  notifies :restart, "service[#{node['confluent']['zookeeper']['service']}]", :delayed
end

template node['confluent']['zookeeper']['logging_config_file'] do
  owner node['confluent']['zookeeper']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['zookeeper']['logging_config_file_mode']
  source 'zookeeper/logging.config.properties.erb'
end

template node['confluent']['zookeeper']['environment_file'] do
  owner node['confluent']['zookeeper']['environment_file_owner']
  group node['confluent']['zookeeper']['environment_file_group']
  mode node['confluent']['zookeeper']['environment_file_mode']
  source 'zookeeper/environment.erb'
  notifies :restart, "service[#{node['confluent']['zookeeper']['service']}]", :delayed
end

template node['confluent']['zookeeper']['file_limit_config'] do
  owner 'root'
  group 'root'
  mode '0644'
  source 'zookeeper/limits.d.conf.erb'
  notifies :restart, "service[#{node['confluent']['zookeeper']['service']}]", :delayed
end

template node['confluent']['zookeeper']['systemd_unit'] do
  owner node['confluent']['zookeeper']['environment_file_owner']
  group node['confluent']['zookeeper']['environment_file_group']
  mode node['confluent']['zookeeper']['environment_file_mode']
  source 'zookeeper/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, "service[#{node['confluent']['zookeeper']['service']}]", :delayed
end

service node['confluent']['zookeeper']['service'] do
  action node['confluent']['zookeeper']['service_action']
end