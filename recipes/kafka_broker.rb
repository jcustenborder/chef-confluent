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
This recipe is used to install an Apache Kafka Broker using the Confluent Platform installations.

@section Examples

#### Standard installation

```json
{
  "confluent": {
    "kafka_broker": {
      "zookeeper_connect": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_broker]"
  ]
}
```

#### Internal Repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "kafka_broker": {
      "zookeeper_connect": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
    },
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_broker]"
  ]
}
```
#>
=end

include_recipe('confluent::default')

required_attributes = %w(broker_id zookeeper_connect)

required_attributes.each do |s|
  unless node['confluent']['kafka_broker'][s]
    Chef::Application.fatal!("node['confluent']['kafka_broker']['#{s}'] must be specified.")
  end
end

user node['confluent']['kafka_broker']['user'] do
  comment 'Service Account for Kafka'
  system true
end

directory node['confluent']['kafka_broker']['log_dir'] do
  owner node['confluent']['kafka_broker']['user']
  group 'root'
  mode node['confluent']['kafka_broker']['log_dir_mode']
  recursive true
end

directory node['confluent']['kafka_broker']['data_dir'] do
  owner node['confluent']['kafka_broker']['user']
  group 'root'
  mode node['confluent']['kafka_broker']['data_dir_mode']
  recursive true
end

template node['confluent']['kafka_broker']['config_file'] do
  owner node['confluent']['kafka_broker']['config_file_owner']
  group 'root'
  mode node['confluent']['kafka_broker']['config_file_mode']
  source 'broker/server.properties.erb'
  notifies :restart, "service[#{node['confluent']['kafka_broker']['service']}]", :immediately
end

template node['confluent']['kafka_broker']['logging_config_file'] do
  owner node['confluent']['kafka_broker']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['kafka_broker']['logging_config_file_mode']
  source 'broker/logging.config.properties.erb'
end

template node['confluent']['kafka_broker']['environment_file'] do
  owner node['confluent']['kafka_broker']['environment_file_owner']
  group node['confluent']['kafka_broker']['environment_file_group']
  mode node['confluent']['kafka_broker']['environment_file_mode']
  source 'broker/environment.erb'
  notifies :restart, "service[#{node['confluent']['kafka_broker']['service']}]", :immediately
end

template node['confluent']['kafka_broker']['file_limit_config'] do
  owner 'root'
  group 'root'
  mode '0644'
  source 'broker/limits.d.conf.erb'
  notifies :restart, "service[#{node['confluent']['kafka_broker']['service']}]", :immediately
end

template node['confluent']['kafka_broker']['systemd_unit'] do
  owner node['confluent']['kafka_broker']['environment_file_owner']
  group node['confluent']['kafka_broker']['environment_file_group']
  mode node['confluent']['kafka_broker']['environment_file_mode']
  source 'broker/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, "service[#{node['confluent']['kafka_broker']['service']}]", :immediately
end

service node['confluent']['kafka_broker']['service'] do
  action node['confluent']['kafka_broker']['service_action']
end