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
  source 'schema_registry/schema-registry.properties.erb'
end

template node['confluent']['control_center']['logging_config_file'] do
  owner node['confluent']['control_center']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['control_center']['logging_config_file_mode']
  source 'schema_registry/logging.config.properties.erb'
end

template node['confluent']['control_center']['environment_file'] do
  owner node['confluent']['control_center']['environment_file_owner']
  group node['confluent']['control_center']['environment_file_group']
  mode node['confluent']['control_center']['environment_file_mode']
  source 'schema_registry/environment.erb'
end

template node['confluent']['control_center']['systemd_unit'] do
  owner node['confluent']['control_center']['environment_file_owner']
  group node['confluent']['control_center']['environment_file_group']
  mode node['confluent']['control_center']['environment_file_mode']
  source 'schema_registry/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
end

service node['confluent']['control_center']['service'] do
  action node['confluent']['control_center']['service_action']
end