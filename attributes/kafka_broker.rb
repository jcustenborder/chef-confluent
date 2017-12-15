#<> Kafka user: The username of the system account that will be created on the host machine. All data directories and log directories will be owned by this user.
default['confluent']['kafka_broker']['user']              = 'kafka'
#<> Config File owner: The owner for the configuration file.
default['confluent']['kafka_broker']['config_file_owner'] = 'root'
#<> Config File mode: The permissions for the configuration file.
default['confluent']['kafka_broker']['config_file_mode']  = '0644'
#<> Config File: The path to the configuration file.
default['confluent']['kafka_broker']['config_file']       = '/etc/kafka/server.properties'
#<> Logging Config File: The owner of the logging config
default['confluent']['kafka_broker']['logging_config_file_owner'] = 'root'
#<> Logging Config Mode: The permissions for the logging config.
default['confluent']['kafka_broker']['logging_config_file_mode']  = '0644'
#<> Logging Config: The path to the logging config.
default['confluent']['kafka_broker']['logging_config_file']       = '/etc/kafka/server.logging.properties'
#<> Data directory: The location to store the data.
default['confluent']['kafka_broker']['data_dir']                       = '/var/lib/kafka'
#<> Data directory Mode: The permissions for the data directory.
default['confluent']['kafka_broker']['data_dir_mode']                  = '0755'
#<> Log directory: The directory to store the application logs.
default['confluent']['kafka_broker']['log_dir']                        = '/var/log/kafka'
#<> Log directory Mode: The permissions to the log directory.
default['confluent']['kafka_broker']['log_dir_mode']                   = '0755'
#<> Service Name: The name of the service
default['confluent']['kafka_broker']['service']                        = 'kafka'
#<> Service Action: The actions for the service
default['confluent']['kafka_broker']['service_action']                 = [:enable, :start]
#<> SystemD Unit: The path to the SystemD unit.
default['confluent']['kafka_broker']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/kafka.service'
      when 'rhel'
        '/usr/lib/systemd/system/kafka.service'
    end

#<> Limit.d config: The path to the limit.d file for the service account user.
default['confluent']['kafka_broker']['file_limit_config'] = '/etc/security/limits.d/99-confluent-kafka-broker.config'
#<> Limit.d nofile: The maximum number of file handles to the process.
default['confluent']['kafka_broker']['file_limit'] = 1000000
default['confluent']['kafka_broker']['systemd_unit_mode']              = '0644'
default['confluent']['kafka_broker']['systemd_unit_owner']             = 'root'
default['confluent']['kafka_broker']['systemd_unit_group']             = 'root'
default['confluent']['kafka_broker']['systemd_service_timeoutstopsec'] = 300


default['confluent']['kafka_broker']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/kafka'
      when 'rhel'
        '/etc/sysconfig/kafka'
    end
default['confluent']['kafka_broker']['environment_file_owner'] = 'root'
default['confluent']['kafka_broker']['environment_file_group'] = 'root'
default['confluent']['kafka_broker']['environment_file_mode']  = '0644'
default['confluent']['kafka_broker']['heap_opts']              = '-Xmx1000M'
default['confluent']['kafka_broker']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['kafka_broker']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['kafka_broker']['zookeeper_connect'] = 'localhost:2181'
default['confluent']['kafka_broker']['config']            = {
    'confluent.support.customer.id'                => 'anonymous',
    'confluent.support.metrics.enable'             => true,
    'group.initial.rebalance.delay.ms'             => 0,
    'log.retention.check.interval.ms'              => 300000,
    'log.retention.hours'                          => 168,
    'log.segment.bytes'                            => 1073741824,
    'num.io.threads'                               => 8,
    'num.network.threads'                          => [3, node['cpu']['total'].to_i].max,
    'num.partitions'                               => 1,
    'num.recovery.threads.per.data.dir'            => 1,
    'offsets.topic.replication.factor'             => 3,
    'socket.receive.buffer.bytes'                  => 102400,
    'socket.request.max.bytes'                     => 104857600,
    'socket.send.buffer.bytes'                     => 102400,
    'transaction.state.log.min.isr'                => 2,
    'transaction.state.log.replication.factor'     => 3,
    'zookeeper.connection.timeout.ms'              => 6000,
    'metric.reporters'                             => 'io.confluent.metrics.reporter.ConfluentMetricsReporter',
    'confluent.metrics.reporter.bootstrap.servers' => 'localhost:9092'
}

default['confluent']['kafka_broker']['logging_config'] = {
    'log4j.rootLogger'                                   => 'INFO, stdout, roller, authorizer',
    'log4j.appender.stdout'                              => 'org.apache.log4j.ConsoleAppender',
    'log4j.appender.stdout.layout'                       => 'org.apache.log4j.PatternLayout',
    'log4j.appender.stdout.layout.ConversionPattern'     => '[%d] %p %m (%c)%n',
    'log4j.appender.roller'                              => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.roller.DatePattern'                  => "'.'yyyy-MM-dd-HH",
    'log4j.appender.roller.File'                         => '${kafka.logs.dir}/server.log',
    'log4j.appender.roller.layout'                       => 'org.apache.log4j.PatternLayout',
    'log4j.appender.roller.layout.ConversionPattern'     => '[%d] %p %m (%c)%n',
    'log4j.appender.state'                               => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.state.DatePattern'                   => "'.'yyyy-MM-dd-HH",
    'log4j.appender.state.File'                          => '${kafka.logs.dir}/state-change.log',
    'log4j.appender.state.layout'                        => 'org.apache.log4j.PatternLayout',
    'log4j.appender.state.layout.ConversionPattern'      => '[%d] %p %m (%c)%n',
    'log4j.appender.request'                             => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.request.DatePattern'                 => "'.'yyyy-MM-dd-HH",
    'log4j.appender.request.File'                        => '${kafka.logs.dir}/kafka-request.log',
    'log4j.appender.request.layout'                      => 'org.apache.log4j.PatternLayout',
    'log4j.appender.request.layout.ConversionPattern'    => '[%d] %p %m (%c)%n',
    'log4j.appender.cleaner'                             => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.cleaner.DatePattern'                 => "'.'yyyy-MM-dd-HH",
    'log4j.appender.cleaner.File'                        => '${kafka.logs.dir}/log-cleaner.log',
    'log4j.appender.cleaner.layout'                      => 'org.apache.log4j.PatternLayout',
    'log4j.appender.cleaner.layout.ConversionPattern'    => '[%d] %p %m (%c)%n',
    'log4j.appender.controller'                          => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.controller.DatePattern'              => "'.'yyyy-MM-dd-HH",
    'log4j.appender.controller.File'                     => '${kafka.logs.dir}/controller.log',
    'log4j.appender.controller.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.controller.layout.ConversionPattern' => '[%d] %p %m (%c)%n',
    'log4j.appender.authorizer'                          => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.authorizer.DatePattern'              => "'.'yyyy-MM-dd-HH",
    'log4j.appender.authorizer.File'                     => '${kafka.logs.dir}/kafka-authorizer.log',
    'log4j.appender.authorizer.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.authorizer.layout.ConversionPattern' => '[%d] %p %m (%c)%n',
    'log4j.logger.org.I0Itec.zkclient.ZkClient'          => 'INFO',
    'log4j.logger.org.apache.zookeeper'                  => 'INFO',
    'log4j.logger.kafka'                                 => 'INFO',
    'log4j.logger.org.apache.kafka'                      => 'INFO',
    'log4j.logger.kafka.request.logger'                  => 'WARN, request',
    'log4j.additivity.kafka.request.logger'              => false,
    'log4j.logger.kafka.network.RequestChannel$'         => 'WARN, request',
    'log4j.additivity.kafka.network.RequestChannel$'     => false,
    'log4j.logger.kafka.controller'                      => 'TRACE, controller',
    'log4j.additivity.kafka.controller'                  => false,
    'log4j.logger.kafka.log.LogCleaner'                  => 'INFO, cleaner',
    'log4j.additivity.kafka.log.LogCleaner'              => false,
    'log4j.logger.state.change.logger'                   => 'TRACE, state',
    'log4j.additivity.state.change.logger'               => false,
    'log4j.logger.kafka.authorizer.logger'               => 'WARN, authorizer',
    'log4j.additivity.kafka.authorizer.logger'           => false,
}