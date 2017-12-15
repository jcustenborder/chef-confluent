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
This recipe is used to install the Confluent Schema Registry using the Confluent installation packages.
#>
=end

require 'chef/application'

include_recipe('confluent::default')

unless node['confluent']['schema_registry']['kafkastore_connection_url']
  Chef::Application.fatal!("node['confluent']['schema_registry']['kafkastore_connection_url'] must be specified.")
end

user node['confluent']['schema_registry']['user'] do
  comment 'Service Account for Schema Registry'
  system true
end

directory node['confluent']['schema_registry']['log_dir'] do
  owner node['confluent']['schema_registry']['user']
  group node['confluent']['schema_registry']['user']
  mode node['confluent']['schema_registry']['log_dir_mode']
  recursive true
end

template node['confluent']['schema_registry']['config_file'] do
  owner node['confluent']['schema_registry']['config_file_owner']
  group 'root'
  mode node['confluent']['schema_registry']['config_file_mode']
  source 'schema_registry/schema-registry.properties.erb'
  notifies :restart, "service[#{node['confluent']['schema_registry']['service']}]", :immediately
end

template node['confluent']['schema_registry']['logging_config_file'] do
  owner node['confluent']['schema_registry']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['schema_registry']['logging_config_file_mode']
  source 'schema_registry/logging.config.properties.erb'
end

template node['confluent']['schema_registry']['environment_file'] do
  owner node['confluent']['schema_registry']['environment_file_owner']
  group node['confluent']['schema_registry']['environment_file_group']
  mode node['confluent']['schema_registry']['environment_file_mode']
  source 'schema_registry/environment.erb'
  notifies :restart, "service[#{node['confluent']['schema_registry']['service']}]", :immediately
end

template node['confluent']['schema_registry']['file_limit_config'] do
  owner 'root'
  group 'root'
  mode '0644'
  source 'schema_registry/limits.d.conf.erb'
  notifies :restart, "service[#{node['confluent']['schema_registry']['service']}]", :immediately
end

template node['confluent']['schema_registry']['systemd_unit'] do
  owner node['confluent']['schema_registry']['environment_file_owner']
  group node['confluent']['schema_registry']['environment_file_group']
  mode node['confluent']['schema_registry']['environment_file_mode']
  source 'schema_registry/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, "service[#{node['confluent']['schema_registry']['service']}]", :immediately
end

service node['confluent']['schema_registry']['service'] do
  action node['confluent']['schema_registry']['service_action']
end