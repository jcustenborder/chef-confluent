default['confluent']['kafka_connect_distributed']['user']              = 'connect-distributed'
default['confluent']['kafka_connect_distributed']['config_file_owner'] = 'root'
default['confluent']['kafka_connect_distributed']['config_file_mode']  = '0644'
default['confluent']['kafka_connect_distributed']['config_file']       = '/etc/kafka/connect-distributed.properties'

default['confluent']['kafka_connect_distributed']['logging_config_file_owner'] = 'root'
default['confluent']['kafka_connect_distributed']['logging_config_file_mode']  = '0644'
default['confluent']['kafka_connect_distributed']['logging_config_file']       = '/etc/kafka/connect-distributed.logging.properties'

default['confluent']['kafka_connect_distributed']['log_dir']                        = '/var/log/kafka-connect-distributed'
default['confluent']['kafka_connect_distributed']['log_dir_mode']                   = '0755'
default['confluent']['kafka_connect_distributed']['service']                        = 'kafka-connect-distributed'
default['confluent']['kafka_connect_distributed']['service_action']                 = [:enable, :start]
default['confluent']['kafka_connect_distributed']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/kafka-connect-distributed.service'
      when 'rhel'
        '/usr/lib/systemd/system/kafka-connect-distributed.service'
    end
default['confluent']['kafka_connect_distributed']['file_limit_config']              = '/etc/security/limits.d/99-confluent-kafka-connect-distributed.config'
default['confluent']['kafka_connect_distributed']['file_limit']                     = 4096
default['confluent']['kafka_connect_distributed']['systemd_unit_mode']              = '0644'
default['confluent']['kafka_connect_distributed']['systemd_unit_owner']             = 'root'
default['confluent']['kafka_connect_distributed']['systemd_unit_group']             = 'root'
default['confluent']['kafka_connect_distributed']['systemd_service_timeoutstopsec'] = 60


default['confluent']['kafka_connect_distributed']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/kafka-connect-distributed'
      when 'rhel'
        '/etc/sysconfig/kafka-connect-distributed'
    end
default['confluent']['kafka_connect_distributed']['environment_file_owner'] = 'root'
default['confluent']['kafka_connect_distributed']['environment_file_group'] = 'root'
default['confluent']['kafka_connect_distributed']['environment_file_mode']  = '0640'
default['confluent']['kafka_connect_distributed']['heap_opts']              = '-Xmx1000M'
default['confluent']['kafka_connect_distributed']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['kafka_connect_distributed']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['kafka_connect_distributed']['zookeeper_connect'] = 'localhost:2181'
default['confluent']['kafka_connect_distributed']['config']            = {
    'key.converter'                           => 'org.apache.kafka.connect.json.JsonConverter',
    'value.converter'                         => 'org.apache.kafka.connect.json.JsonConverter',
    'key.converter.schemas.enable'            => true,
    'value.converter.schemas.enable'          => true,
    'internal.key.converter'                  => 'org.apache.kafka.connect.json.JsonConverter',
    'internal.value.converter'                => 'org.apache.kafka.connect.json.JsonConverter',
    'internal.key.converter.schemas.enable'   => false,
    'internal.value.converter.schemas.enable' => false,
    'offset.storage.topic'                    => 'connect-offsets',
    'offset.storage.replication.factor'       => 3,
    'config.storage.topic'                    => 'connect-configs',
    'config.storage.replication.factor'       => 3,
    'status.storage.topic'                    => 'connect-status',
    'status.storage.replication.factor'       => 3,
    'offset.flush.interval.ms'                => 10000,
    'plugin.path'                             => '/usr/share/java',
}

default['confluent']['kafka_connect_distributed']['logging_config'] = {
    'log4j.rootLogger'                               => 'INFO, stdout, roller',
    'log4j.appender.stdout'                          => 'org.apache.log4j.ConsoleAppender',
    'log4j.appender.stdout.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.stdout.layout.ConversionPattern' => '[%d] %p %m (%c)%n',
    'log4j.appender.roller'                          => 'org.apache.log4j.DailyRollingFileAppender',
    'log4j.appender.roller.DatePattern'              => "'.'yyyy-MM-dd-HH",
    'log4j.appender.roller.File'                     => '${kafka.logs.dir}/server.log',
    'log4j.appender.roller.layout'                   => 'org.apache.log4j.PatternLayout',
    'log4j.appender.roller.layout.ConversionPattern' => '[%d] %p %m (%c)%n',
}