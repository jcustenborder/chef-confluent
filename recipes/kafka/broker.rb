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

include_recipe('confluent::default')

user node['confluent']['kafka']['broker']['user'] do
  comment 'Service Account for Kafka'
  system true
end

directory node['confluent']['kafka']['broker']['log_dir'] do
  owner node['confluent']['kafka']['broker']['user']
  group 'root'
  mode node['confluent']['kafka']['broker']['log_dir_mode']
  recursive true
end

directory node['confluent']['kafka']['broker']['data_dir'] do
  owner node['confluent']['kafka']['broker']['user']
  group 'root'
  mode node['confluent']['kafka']['broker']['data_dir_mode']
  recursive true
end

template node['confluent']['kafka']['broker']['config_file'] do
  owner node['confluent']['kafka']['broker']['config_file_owner']
  group 'root'
  mode node['confluent']['kafka']['broker']['config_file_mode']
  source 'broker/server.properties.erb'
end

template node['confluent']['kafka']['broker']['logging_config_file'] do
  owner node['confluent']['kafka']['broker']['logging_config_file_owner']
  group 'root'
  mode node['confluent']['kafka']['broker']['logging_config_file_mode']
  source 'broker/logging.config.properties.erb'
end

template node['confluent']['kafka']['broker']['environment_file'] do
  owner node['confluent']['kafka']['broker']['environment_file_owner']
  group node['confluent']['kafka']['broker']['environment_file_group']
  mode node['confluent']['kafka']['broker']['environment_file_mode']
  source 'broker/environment.erb'
end

template node['confluent']['kafka']['broker']['systemd_unit'] do
  owner node['confluent']['kafka']['broker']['environment_file_owner']
  group node['confluent']['kafka']['broker']['environment_file_group']
  mode node['confluent']['kafka']['broker']['environment_file_mode']
  source 'broker/systemd.erb'
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
end

service node['confluent']['kafka']['broker']['service'] do
  action node['confluent']['kafka']['broker']['service_action']
end