default['confluent']['broker_user']              = 'kafka'
default['confluent']['broker_config_file_owner'] = 'root'
default['confluent']['broker_config_file_mode']  = '0644'
default['confluent']['broker_config_file']       = '/etc/kafka/server.properties'

default['confluent']['broker_logging_config_file_owner'] = 'root'
default['confluent']['broker_logging_config_file_mode']  = '0644'
default['confluent']['broker_logging_config_file']       = '/etc/kafka/server.logging.properties'

default['confluent']['broker_data_dir']                       = '/var/lib/kafka'
default['confluent']['broker_data_dir_mode']                  = '0755'
default['confluent']['broker_log_dir']                        = '/var/log/kafka'
default['confluent']['broker_log_dir_mode']                   = '0755'
default['confluent']['broker_service']                        = 'kafka'
default['confluent']['broker_service_action']                 = [:enable, :start]
default['confluent']['manage_service']                        = true
default['confluent']['broker_systemd_unit']                   = File.join(
    "#{default['confluent']['systemd_dir']}",
    "#{default['confluent']['kafka_service']}.service"
)
default['confluent']['broker_systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/kafka.service'
      when 'rhel'
        '/usr/lib/systemd/system/kafka.service'
    end
default['confluent']['broker_systemd_unit_mode']              = '0644'
default['confluent']['broker_systemd_unit_owner']             = 'root'
default['confluent']['broker_systemd_unit_group']             = 'root'
default['confluent']['broker_systemd_service_limitnofile']    = 65536
default['confluent']['broker_systemd_service_timeoutstopsec'] = 300


default['confluent']['broker_environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/kafka'
      when 'rhel'
        '/etc/sysconfig/kafka'
    end
default['confluent']['broker_environment_file_owner'] = 'root'
default['confluent']['broker_environment_file_group'] = 'root'
default['confluent']['broker_environment_file_mode']  = '0644'
default['confluent']['broker_heap_opts']              = '-Xmx1000M'
default['confluent']['broker_kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['broker_environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['broker_config'] = {
    'confluent.support.customer.id'            => 'anonymous',
    'confluent.support.metrics.enable'         => true,
    'group.initial.rebalance.delay.ms'         => 0,
    'log.dirs'                                 => default['confluent']['broker_data_dir'].to_s,
    'log.retention.check.interval.ms'          => 300000,
    'log.retention.hours'                      => 168,
    'log.segment.bytes'                        => 1073741824,
    'num.io.threads'                           => 8,
    'num.network.threads'                      => 3,
    'num.partitions'                           => 1,
    'num.recovery.threads.per.data.dir'        => 1,
    'offsets.topic.replication.factor'         => 1,
    'socket.receive.buffer.bytes'              => 102400,
    'socket.request.max.bytes'                 => 104857600,
    'socket.send.buffer.bytes'                 => 102400,
    'transaction.state.log.min.isr'            => 1,
    'transaction.state.log.replication.factor' => 1,
    'zookeeper.connect'                        => 'localhost:2181',
    'zookeeper.connection.timeout.ms'          => 6000,
}

default['confluent']['broker_logging_config'] = {
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