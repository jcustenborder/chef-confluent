name 'confluent'
maintainer 'Jeremy Custenborder'
maintainer_email 'jcustenborder@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures confluent'
long_description 'Installs/Configures confluent'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/jcustenborder/chef-confluent/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/jcustenborder/chef-confluent'

cookbook 'confluent'

# all_recipies = %w(confluent::default confluent::control_center confluent::kakfa_broker
# confluent::kafka_connect_distributed confluent::kafka_connect_standalone confluent::schema_registry confluent::zookeeper)
#
# recipe 'confluent::default', 'Manages the installation of the software repositories. Required by all recipes.'
# recipe 'control_center', 'Manages the installation of Confluent Control Center.'
# recipe 'kafka_broker', 'Manages the installation of an Apache Kafka Broker.'
# recipe 'kafka_connect_distributed', 'Manages the installation of an Apache Kafka Connect worker in distributed mode.'
# recipe 'kafka_connect_standalone', 'Manages the installation of an Apache Kafka Connect worker in standalone mode.'
# recipe 'schema_registry', 'Manages the installation of an Apache Zookeeper server.'