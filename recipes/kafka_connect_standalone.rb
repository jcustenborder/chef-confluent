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
This recipe is used to install an Apache Kafka Connect worker in standalone mode using the Confluent installation packages.
#>
=end

require 'chef/application'

include_recipe('confluent::default')

required_attributes = %w(bootstrap_servers group_id)

required_attributes.each do |s|
  unless node['confluent']['kafka_connect_standalone'][s]
    Chef::Application.fatal!("node['confluent']['kafka_connect_standalone']['#{s}'] must be specified.")
  end
end


user node['confluent']['kafka_connect_standalone']['user'] do
  comment 'Service Account for Kafka Connect Distributed'
  system true
end

directory node['confluent']['kafka_connect_standalone']['log_dir'] do
  owner node['confluent']['kafka_connect_standalone']['user']
  group node['confluent']['kafka_connect_standalone']['user']
  mode node['confluent']['kafka_connect_standalone']['log_dir_mode']
  recursive true
end

template node['confluent']['kafka_connect_standalone']['config_file'] do
  owner node['confluent']['kafka_connect_standalone']['config_file_owner']
  group 'root'
  mode node['confluent']['kafka_connect_standalone']['config_file_mode']
  source 'kafka_connect_distributed/connect-distributed.properties.erb'
  notifies :restart, "service[#{node['confluent']['kafka_connect_standalone']['service']}]", :immediately
end

template node['confluent']['kafka_connect_standalone']['logging_config_file'] do
  owner node['confluent']['kafka_connect_standalone']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['kafka_connect_standalone']['logging_config_file_mode']
  source 'kafka_connect_distributed/logging.config.properties.erb'
end

template node['confluent']['kafka_connect_standalone']['environment_file'] do
  owner node['confluent']['kafka_connect_standalone']['environment_file_owner']
  group node['confluent']['kafka_connect_standalone']['environment_file_group']
  mode node['confluent']['kafka_connect_standalone']['environment_file_mode']
  source 'kafka_connect_distributed/environment.erb'
  notifies :restart, "service[#{node['confluent']['kafka_connect_standalone']['service']}]", :immediately
end

template node['confluent']['kafka_connect_standalone']['file_limit_config'] do
  owner 'root'
  group 'root'
  mode '0644'
  source 'kafka_connect_distributed/limits.d.conf.erb'
  notifies :restart, "service[#{node['confluent']['kafka_connect_standalone']['service']}]", :immediately
end

template node['confluent']['kafka_connect_standalone']['systemd_unit'] do
  owner node['confluent']['kafka_connect_standalone']['environment_file_owner']
  group node['confluent']['kafka_connect_standalone']['environment_file_group']
  mode node['confluent']['kafka_connect_standalone']['environment_file_mode']
  source 'kafka_connect_distributed/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, "service[#{node['confluent']['kafka_connect_standalone']['service']}]", :immediately
end

service node['confluent']['kafka_connect_standalone']['service'] do
  action node['confluent']['kafka_connect_standalone']['service_action']
end