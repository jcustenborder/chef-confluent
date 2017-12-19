#
# Cookbook:: confluent
# Recipe:: control_center
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
#
=begin
#<
This recipe is used to install the Confluent Control Center monitoring application.

@section Examples

#### Standard installation

```json
{
  "confluent": {
    "control_center": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "zookeeper_connect": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
    }
  },
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
    "control_center": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "zookeeper_connect": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
    },
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::control_center]"
  ]
}
```

#>
=end

require 'chef/application'

include_recipe('confluent::default')

required_attributes = %w(bootstrap_servers zookeeper_connect)

required_attributes.each do |s|
  unless node['confluent']['control_center'][s]
    Chef::Application.fatal!("node['confluent']['control_center']['#{s}'] must be specified.")
  end
end

unless node['confluent']['control_center']['bootstrap_servers']
  Chef::Application.fatal!("node['confluent']['control_center']['kafkastore_connection_url'] must be specified.")
end

user node['confluent']['control_center']['user'] do
  comment 'Service Account for Schema Registry'
  system true
end

directory node['confluent']['control_center']['data_dir'] do
  owner node['confluent']['control_center']['user']
  owner node['confluent']['control_center']['user']
  mode node['confluent']['control_center']['data_dir_mode']
  recursive true
end

directory node['confluent']['control_center']['log_dir'] do
  owner node['confluent']['control_center']['user']
  group node['confluent']['control_center']['user']
  mode node['confluent']['control_center']['log_dir_mode']
  recursive true
end

template node['confluent']['control_center']['config_file'] do
  owner node['confluent']['control_center']['config_file_owner']
  group 'root'
  mode node['confluent']['control_center']['config_file_mode']
  source 'control_center/control-center.properties.erb'
  notifies :restart, "service[#{node['confluent']['control_center']['service']}]", :delayed
end

template node['confluent']['control_center']['logging_config_file'] do
  owner node['confluent']['control_center']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['control_center']['logging_config_file_mode']
  source 'control_center/logging.config.properties.erb'
end

template node['confluent']['control_center']['environment_file'] do
  owner node['confluent']['control_center']['environment_file_owner']
  group node['confluent']['control_center']['environment_file_group']
  mode node['confluent']['control_center']['environment_file_mode']
  source 'control_center/environment.erb'
  notifies :restart, "service[#{node['confluent']['control_center']['service']}]", :delayed
end

template node['confluent']['control_center']['file_limit_config'] do
  owner 'root'
  group 'root'
  mode '0644'
  source 'control_center/limits.d.conf.erb'
  notifies :restart, "service[#{node['confluent']['control_center']['service']}]", :delayed
end

template node['confluent']['control_center']['systemd_unit'] do
  owner node['confluent']['control_center']['environment_file_owner']
  group node['confluent']['control_center']['environment_file_group']
  mode node['confluent']['control_center']['environment_file_mode']
  source 'control_center/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, "service[#{node['confluent']['control_center']['service']}]", :delayed
end

service node['confluent']['control_center']['service'] do
  action node['confluent']['control_center']['service_action']
end