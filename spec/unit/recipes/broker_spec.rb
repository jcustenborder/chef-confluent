#
# Cookbook:: confluent
# Spec:: default
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

require 'spec_helper'

# contexts = {
#     'When all attributes are default, on Ubuntu 16.04' => ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04'),
#     'When all attributes are default, on CentOS 7.4.1708' => ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
# }

describe 'confluent::broker' do
  context 'on CentOS 7.4.1708' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'include_recipe::default' do
      expect(chef_run).to include_recipe('confluent::default')
    end

    it 'include package confluent-platform-2.11' do
      expect(chef_run).to install_package('confluent-platform-2.11')
    end

    it 'has kafka user' do
      expect(chef_run).to create_user('kafka')
    end

    it 'has data directory' do
      expect(chef_run).to create_directory('/var/lib/kafka')
    end

    it 'has log directory' do
      expect(chef_run).to create_directory('/var/log/kafka')
    end

    it 'has template server.properties' do
      expect(chef_run).to create_template('/etc/kafka/server.properties')
    end

    it 'has template server.logging.properties' do
      expect(chef_run).to create_template('/etc/kafka/server.logging.properties')
    end
  end
end
