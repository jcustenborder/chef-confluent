# Description

This cookbook is for installing and maintaining the [Confluent Platform](https://www.confluent.io). The default is to install and
configure the enterprise version of the platform.


# Requirements

Internet access is required to install the packages from the Confluent Repositories. If this is not possible mirror the
repositories to you local network.

[Debian & Ubuntu](https://docs.confluent.io/current/installation/installing_cp.html#debian-and-ubuntu)

[RHEL & Centos](https://docs.confluent.io/current/installation/installing_cp.html#rhel-and-centos)


## Platform:

* ubuntu (>= 15.04)
* debian (>= 8.0)
* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* #<Logger:0x007fb1dc1b4b68> () (Recommended but not required)
* #<Logger:0x007fb1dc1b4b68> () (Suggested but not required)
* Conflicts with #<Logger:0x007fb1dc1b4b68> ()

# Attributes

* `node['confluent']['control_center']['user']` - Control Center User: The username of the system account that will be created on the host machine. All data directories and log directories will be owned by this user. Defaults to `control-center`.
* `node['confluent']['control_center']['config_file_owner']` - Config file owner: The user that will own the configuration files. Defaults to `root`.
* `node['confluent']['control_center']['config_file_mode']` - Config file mode: The permissions associated with the configuration file. Defaults to `0644`.
* `node['confluent']['control_center']['config_file']` - Config file path: The location on the file system for the configuration file. Defaults to `/etc/confluent-control-center/control-center.properties`.
* `node['confluent']['control_center']['logging_config_file_owner']` - Logging Config file owner: The owner of the logging config file. Defaults to `root`.
* `node['confluent']['control_center']['logging_config_file_mode']` - Logging Config file mode: The permissions associated with the logging configuration file. Defaults to `0644`.
* `node['confluent']['control_center']['logging_config_file']` - Logging Config file path: The location on the file system for the logging configuration file. Defaults to `/etc/confluent-control-center/control-center.logging.properties`.
* `node['confluent']['control_center']['data_dir']` - Data Directory path: The location on the file system to store the data for Control Center. Defaults to `/var/lib/confluent-control-center`.
* `node['confluent']['control_center']['data_dir_mode']` - Data Directory Mode: The file system permissions associated with the data directory. Defaults to `0755`.
* `node['confluent']['control_center']['log_dir']` - Log Directory path: The location on the file system to store the logs for Control Center. Defaults to `/var/log/confluent-control-center`.
* `node['confluent']['control_center']['log_dir_mode']` - Data Directory Mode: The file system permissions associated with the log directory. Defaults to `0755`.
* `node['confluent']['control_center']['service']` - Service Name: The name of the service in SystemD. Defaults to `confluent-control-center`.
* `node['confluent']['control_center']['service_action']` - Service Action: Actions for the service. Defaults to `[ ... ]`.
* `node['confluent']['control_center']['systemd_unit']` - SystemD Unit path: The location for the SystemD unit. Defaults to `case node['platform_family']`.
* `node['confluent']['control_center']['file_limit_config']` - Limits.d conf path: The location of the limits.d config for Control Center. Defaults to `/etc/security/limits.d/99-confluent-control-center.config`.
* `node['confluent']['control_center']['file_limit']` - File limit: The maximum number of file handles that Control Center will be allowed to open. Defaults to `100000`.
* `node['confluent']['control_center']['systemd_unit_mode']` - SystemD file mode: The permissions for the SystemD Unit on the filesystem. Defaults to `0644`.
* `node['confluent']['control_center']['systemd_unit_owner']` - SystemD file owner: The owner for the SystemD Unit on the filesystem. Defaults to `root`.
* `node['confluent']['control_center']['systemd_unit_group']` - SystemD file group: The group for the SystemD Unit on the filesystem. Defaults to `root`.
* `node['confluent']['control_center']['systemd_service_timeoutstopsec']` - SystemD TimeoutStopSec: The amount of time for SystemD to wait for the process to stop. This should be a considerable amount of time to allow the process to exit cleanly and prevent corruption. Defaults to `300`.
* `node['confluent']['control_center']['environment_file']` - SystemD EnvironmentFile: The path to the file containing environment variables that will be used when the application is started. Defaults to `case node['platform_family']`.
* `node['confluent']['control_center']['environment_file_owner']` - SystemD EnvironmentFile owner: The owner for the SystemD EnvironmentFile. Defaults to `root`.
* `node['confluent']['control_center']['environment_file_group']` - SystemD EnvironmentFile group: The group for the SystemD EnvironmentFile. Defaults to `root`.
* `node['confluent']['control_center']['environment_file_mode']` - SystemD EnvironmentFile mode: The filesystem permissions for the SystemD EnvironmentFile. Defaults to `0644`.
* `node['confluent']['control_center']['heap_opts']` - Java heap options: The amount of heap the process should be started with. Defaults to `-Xmx1000M`.
* `node['confluent']['control_center']['kafka_opts']` - Java additional options: Additional options that can be passed to the java process. This is where Kerberos and JAAS files should be specified. Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['control_center']['environment_config']` - Java additional options: Additional options that can be passed to the java process. This is where Kerberos and JAAS files should be specified. Defaults to `{ ... }`.
* `node['confluent']['control_center']['config']` - Control Center configuration options: Configuration options that will be placed in the config file. Defaults to `{ ... }`.
* `node['confluent']['control_center']['logging_config']` - Control Center logging config: Logging configuration for log4j. Defaults to `{ ... }`.
* `node['confluent']['yum_repository_url']` - YUM repository url: Location to pull the packages from. Defaults to `http://packages.confluent.io/rpm/4.0`.
* `node['confluent']['yum_dist_repository_url']` - YUM dist repository url: Location to pull the packages from. This is additional packages that are specific to EL7. Defaults to `http://packages.confluent.io/rpm/4.0/7`.
* `node['confluent']['yum_key_url']` - YUM GPG Key Url: Location of the GPG key for the YUM repositories. Defaults to `http://packages.confluent.io/rpm/4.0/archive.key`.
* `node['confluent']['apt_repository_url']` - APT Repository Url: Base location for the apt repository. Defaults to `http://packages.confluent.io/deb/4.0`.
* `node['confluent']['apt_key_url']` - APT Key Url: Location of the GPG key the packages were signed with. Defaults to `http://packages.confluent.io/deb/4.0/archive.key`.
* `node['confluent']['gpg_check']` - GPG Check: Should the package manager check for the GPG signatures. Defaults to `true`.
* `node['confluent']['repo_enabled']` - Repository Enabled: Flag to determine if the repository should be enabled. Defaults to `true`.
* `node['confluent']['package']` - Package to install: Installation package that will be used to install the Confluent Platform. Defaults to `confluent-platform-2.11`.
* `node['confluent']['manage_repo']` - Manage Repository: Flag to determine if the repository should be managed on the host machine. Defaults to `true`.
* `node['confluent']['kafka_broker']['user']` - Kafka user: The username of the system account that will be created on the host machine. All data directories and log directories will be owned by this user. Defaults to `kafka`.
* `node['confluent']['kafka_broker']['config_file_owner']` - Config File owner: The owner for the configuration file. Defaults to `root`.
* `node['confluent']['kafka_broker']['config_file_mode']` - Config File mode: The permissions for the configuration file. Defaults to `0644`.
* `node['confluent']['kafka_broker']['config_file']` - Config File: The path to the configuration file. Defaults to `/etc/kafka/server.properties`.
* `node['confluent']['kafka_broker']['logging_config_file_owner']` - Logging Config File: The owner of the logging config. Defaults to `root`.
* `node['confluent']['kafka_broker']['logging_config_file_mode']` - Logging Config Mode: The permissions for the logging config. Defaults to `0644`.
* `node['confluent']['kafka_broker']['logging_config_file']` - Logging Config: The path to the logging config. Defaults to `/etc/kafka/server.logging.properties`.
* `node['confluent']['kafka_broker']['data_dir']` - Data directory: The location to store the data. Defaults to `/var/lib/kafka`.
* `node['confluent']['kafka_broker']['data_dir_mode']` - Data directory Mode: The permissions for the data directory. Defaults to `0755`.
* `node['confluent']['kafka_broker']['log_dir']` - Log directory: The directory to store the application logs. Defaults to `/var/log/kafka`.
* `node['confluent']['kafka_broker']['log_dir_mode']` - Log directory Mode: The permissions to the log directory. Defaults to `0755`.
* `node['confluent']['kafka_broker']['service']` - Service Name: The name of the service. Defaults to `kafka`.
* `node['confluent']['kafka_broker']['service_action']` - Service Action: The actions for the service. Defaults to `[ ... ]`.
* `node['confluent']['kafka_broker']['systemd_unit']` - SystemD Unit: The path to the SystemD unit. Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_broker']['file_limit_config']` - Limit.d config: The path to the limit.d file for the service account user. Defaults to `/etc/security/limits.d/99-confluent-kafka-broker.config`.
* `node['confluent']['kafka_broker']['file_limit']` - Limit.d nofile: The maximum number of file handles to the process. Defaults to `1000000`.
* `node['confluent']['kafka_broker']['systemd_unit_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_broker']['systemd_unit_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_broker']['systemd_unit_group']` -  Defaults to `root`.
* `node['confluent']['kafka_broker']['systemd_service_timeoutstopsec']` -  Defaults to `300`.
* `node['confluent']['kafka_broker']['environment_file']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_broker']['environment_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_broker']['environment_file_group']` -  Defaults to `root`.
* `node['confluent']['kafka_broker']['environment_file_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_broker']['heap_opts']` -  Defaults to `-Xmx1000M`.
* `node['confluent']['kafka_broker']['kafka_opts']` -  Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['kafka_broker']['environment_config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_broker']['zookeeper_connect']` -  Defaults to `localhost:2181`.
* `node['confluent']['kafka_broker']['config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_broker']['logging_config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_distributed']['user']` -  Defaults to `connect-distributed`.
* `node['confluent']['kafka_connect_distributed']['config_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_distributed']['config_file']` -  Defaults to `/etc/kafka/connect-distributed.properties`.
* `node['confluent']['kafka_connect_distributed']['logging_config_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['logging_config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_distributed']['logging_config_file']` -  Defaults to `/etc/kafka/connect-distributed.logging.properties`.
* `node['confluent']['kafka_connect_distributed']['log_dir']` -  Defaults to `/var/log/kafka-connect-distributed`.
* `node['confluent']['kafka_connect_distributed']['log_dir_mode']` -  Defaults to `0755`.
* `node['confluent']['kafka_connect_distributed']['service']` -  Defaults to `kafka-connect-distributed`.
* `node['confluent']['kafka_connect_distributed']['service_action']` -  Defaults to `[ ... ]`.
* `node['confluent']['kafka_connect_distributed']['systemd_unit']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_connect_distributed']['file_limit_config']` -  Defaults to `/etc/security/limits.d/99-confluent-kafka-connect-distributed.config`.
* `node['confluent']['kafka_connect_distributed']['file_limit']` -  Defaults to `4096`.
* `node['confluent']['kafka_connect_distributed']['systemd_unit_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_distributed']['systemd_unit_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['systemd_unit_group']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['systemd_service_timeoutstopsec']` -  Defaults to `60`.
* `node['confluent']['kafka_connect_distributed']['environment_file']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_connect_distributed']['environment_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['environment_file_group']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_distributed']['environment_file_mode']` -  Defaults to `0640`.
* `node['confluent']['kafka_connect_distributed']['heap_opts']` -  Defaults to `-Xmx1000M`.
* `node['confluent']['kafka_connect_distributed']['kafka_opts']` -  Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['kafka_connect_distributed']['environment_config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_distributed']['zookeeper_connect']` -  Defaults to `localhost:2181`.
* `node['confluent']['kafka_connect_distributed']['config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_distributed']['logging_config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_standalone']['user']` -  Defaults to `connect-distributed`.
* `node['confluent']['kafka_connect_standalone']['config_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_standalone']['config_file']` -  Defaults to `/etc/kafka/connect-distributed.properties`.
* `node['confluent']['kafka_connect_standalone']['logging_config_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['logging_config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_standalone']['logging_config_file']` -  Defaults to `/etc/kafka/connect-distributed.logging.properties`.
* `node['confluent']['kafka_connect_standalone']['log_dir']` -  Defaults to `/var/log/kafka-connect-distributed`.
* `node['confluent']['kafka_connect_standalone']['log_dir_mode']` -  Defaults to `0755`.
* `node['confluent']['kafka_connect_standalone']['service']` -  Defaults to `kafka-connect-distributed`.
* `node['confluent']['kafka_connect_standalone']['service_action']` -  Defaults to `[ ... ]`.
* `node['confluent']['kafka_connect_standalone']['systemd_unit']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_connect_standalone']['file_limit_config']` -  Defaults to `/etc/security/limits.d/99-confluent-kafka-connect-distributed.config`.
* `node['confluent']['kafka_connect_standalone']['file_limit']` -  Defaults to `4096`.
* `node['confluent']['kafka_connect_standalone']['systemd_unit_mode']` -  Defaults to `0644`.
* `node['confluent']['kafka_connect_standalone']['systemd_unit_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['systemd_unit_group']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['systemd_service_timeoutstopsec']` -  Defaults to `60`.
* `node['confluent']['kafka_connect_standalone']['environment_file']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['kafka_connect_standalone']['environment_file_owner']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['environment_file_group']` -  Defaults to `root`.
* `node['confluent']['kafka_connect_standalone']['environment_file_mode']` -  Defaults to `0640`.
* `node['confluent']['kafka_connect_standalone']['heap_opts']` -  Defaults to `-Xmx1000M`.
* `node['confluent']['kafka_connect_standalone']['kafka_opts']` -  Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['kafka_connect_standalone']['environment_config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_standalone']['zookeeper_connect']` -  Defaults to `localhost:2181`.
* `node['confluent']['kafka_connect_standalone']['config']` -  Defaults to `{ ... }`.
* `node['confluent']['kafka_connect_standalone']['logging_config']` -  Defaults to `{ ... }`.
* `node['confluent']['schema_registry']['user']` -  Defaults to `schema-registry`.
* `node['confluent']['schema_registry']['config_file_owner']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['schema_registry']['config_file']` -  Defaults to `/etc/schema-registry/schema-registry.properties`.
* `node['confluent']['schema_registry']['logging_config_file_owner']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['logging_config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['schema_registry']['logging_config_file']` -  Defaults to `/etc/schema-registry/schema-registry.logging.properties`.
* `node['confluent']['schema_registry']['log_dir']` -  Defaults to `/var/log/schema-registry`.
* `node['confluent']['schema_registry']['log_dir_mode']` -  Defaults to `0755`.
* `node['confluent']['schema_registry']['service']` -  Defaults to `schema-registry`.
* `node['confluent']['schema_registry']['service_action']` -  Defaults to `[ ... ]`.
* `node['confluent']['schema_registry']['systemd_unit']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['schema_registry']['file_limit_config']` -  Defaults to `/etc/security/limits.d/99-confluent-schema-registry.config`.
* `node['confluent']['schema_registry']['file_limit']` -  Defaults to `65535`.
* `node['confluent']['schema_registry']['systemd_unit_mode']` -  Defaults to `0644`.
* `node['confluent']['schema_registry']['systemd_unit_owner']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['systemd_unit_group']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['systemd_service_timeoutstopsec']` -  Defaults to `60`.
* `node['confluent']['schema_registry']['environment_file']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['schema_registry']['environment_file_owner']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['environment_file_group']` -  Defaults to `root`.
* `node['confluent']['schema_registry']['environment_file_mode']` -  Defaults to `0644`.
* `node['confluent']['schema_registry']['heap_opts']` -  Defaults to `-Xmx1000M`.
* `node['confluent']['schema_registry']['kafka_opts']` -  Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['schema_registry']['environment_config']` -  Defaults to `{ ... }`.
* `node['confluent']['schema_registry']['config']` -  Defaults to `{ ... }`.
* `node['confluent']['schema_registry']['logging_config']` -  Defaults to `{ ... }`.
* `node['confluent']['zookeeper']['user']` -  Defaults to `zookeeper`.
* `node['confluent']['zookeeper']['config_file_owner']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['zookeeper']['config_file']` -  Defaults to `/etc/kafka/zookeeper.properties`.
* `node['confluent']['zookeeper']['logging_config_file_owner']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['logging_config_file_mode']` -  Defaults to `0644`.
* `node['confluent']['zookeeper']['logging_config_file']` -  Defaults to `/etc/kafka/zookeeper.logging.properties`.
* `node['confluent']['zookeeper']['data_dir']` -  Defaults to `/var/lib/zookeeper`.
* `node['confluent']['zookeeper']['data_dir_mode']` -  Defaults to `0755`.
* `node['confluent']['zookeeper']['log_dir']` -  Defaults to `/var/log/zookeeper`.
* `node['confluent']['zookeeper']['log_dir_mode']` -  Defaults to `0755`.
* `node['confluent']['zookeeper']['service']` -  Defaults to `zookeeper`.
* `node['confluent']['zookeeper']['service_action']` -  Defaults to `[ ... ]`.
* `node['confluent']['zookeeper']['systemd_unit']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['zookeeper']['file_limit_config']` -  Defaults to `/etc/security/limits.d/99-confluent-zookeeper.config`.
* `node['confluent']['zookeeper']['file_limit']` -  Defaults to `65535`.
* `node['confluent']['zookeeper']['systemd_unit_mode']` -  Defaults to `0644`.
* `node['confluent']['zookeeper']['systemd_unit_owner']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['systemd_unit_group']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['systemd_service_timeoutstopsec']` -  Defaults to `300`.
* `node['confluent']['zookeeper']['environment_file']` -  Defaults to `case node['platform_family']`.
* `node['confluent']['zookeeper']['environment_file_owner']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['environment_file_group']` -  Defaults to `root`.
* `node['confluent']['zookeeper']['environment_file_mode']` -  Defaults to `0644`.
* `node['confluent']['zookeeper']['heap_opts']` -  Defaults to `-Xmx1000M`.
* `node['confluent']['zookeeper']['kafka_opts']` -  Defaults to `-Djava.net.preferIPv4Stack=true`.
* `node['confluent']['zookeeper']['environment_config']` -  Defaults to `{ ... }`.
* `node['confluent']['zookeeper']['config']` -  Defaults to `{ ... }`.
* `node['confluent']['zookeeper']['logging_config']` -  Defaults to `{ ... }`.

# Recipes

* [confluent::control_center](#confluentcontrol_center) - This recipe is used to install the Confluent Control Center monitoring application.
* [confluent::default](#confluentdefault) - This recipe is used to install the Confluent YUM or APT repositories and the installation package for the Confluent Platform.
* [confluent::kafka_broker](#confluentkafka_broker) - This recipe is used to install an Apache Kafka Broker using the Confluent Platform installations.
* [confluent::kafka_connect_distributed](#confluentkafka_connect_distributed) - This recipe is used to install an Apache Kafka Connect worker in distributed mode using the Confluent installation packages.
* [confluent::kafka_connect_standalone](#confluentkafka_connect_standalone) - This recipe is used to install an Apache Kafka Connect worker in standalone mode using the Confluent installation packages.
* [confluent::schema_registry](#confluentschema_registry) - This recipe is used to install the Confluent Schema Registry using the Confluent installation packages.
* [confluent::zookeeper](#confluentzookeeper) - This recipe is used to install an Apache Zookeeper server using the Confluent installation packages.

## confluent::control_center

This recipe is used to install the Confluent Control Center monitoring application.


### Examples

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


## confluent::default

This recipe is used to install the Confluent YUM or APT repositories and the installation package for the Confluent
Platform.


### Examples

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

## confluent::kafka_broker

This recipe is used to install an Apache Kafka Broker using the Confluent Platform installations.


### Examples

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

## confluent::kafka_connect_distributed

This recipe is used to install an Apache Kafka Connect worker in distributed mode using the Confluent installation packages.


### Examples

#### Standard installation

```json
{
  "confluent": {
    "kafka_connect_distributed": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "group_id": "connect-cluster-1"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_connect_distributed]"
  ]
}
```

#### Internal Repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "kafka_connect_distributed": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "group_id": "connect-cluster-1"
    },
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_connect_distributed]"
  ]
}
```

## confluent::kafka_connect_standalone

This recipe is used to install an Apache Kafka Connect worker in standalone mode using the Confluent installation packages.


### Examples

#### Standard installation

```json
{
  "confluent": {
    "kafka_connect_standalone": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "group_id": "connect-cluster-1"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_connect_standalone]"
  ]
}
```

#### Internal Repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "kafka_connect_standalone": {
      "bootstrap_servers": "kafka-01:9092,kafka-02:9092,kafka-03:9092",
      "group_id": "connect-cluster-1"
    },
    "default": {
      "yum_repository_url": "http://repo.example.com/confluent/rpm/4.0",
      "yum_dist_repository_url": "http://repo.example.com/confluent/rpm/4.0/7",
      "yum_key_url": "http://repo.example.com/confluent/4.0/archive.key"
    }
  },
  "run_list": [
    "recipe[confluent::kafka_connect_standalone]"
  ]
}
```

## confluent::schema_registry

This recipe is used to install the Confluent Schema Registry using the Confluent installation packages.


### Examples

#### Standard installation

```json
{
  "confluent": {
    "schema_registry": {
      "kafkastore_connection_url": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
    }
  },
  "run_list": [
    "recipe[confluent::schema_registry]"
  ]
}
```

#### Internal Repository

The following example shows how to use an internal repository instead of the Confluent official repositories.

```json
{
  "confluent": {
    "schema_registry": {
      "kafkastore_connection_url": "zookeeper-01:2181,zookeeper-02:2181,zookeeper-03:2181"
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

## confluent::zookeeper

This recipe is used to install an Apache Zookeeper server using the Confluent installation packages.


### Examples

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

