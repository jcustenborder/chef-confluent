default['confluent']['kafka']['connect_standalone']['user']              = 'connect-distributed'
default['confluent']['kafka']['connect_standalone']['config_file_owner'] = 'root'
default['confluent']['kafka']['connect_standalone']['config_file_mode']  = '0644'
default['confluent']['kafka']['connect_standalone']['config_file']       = '/etc/kafka/connect-distributed.properties'

default['confluent']['kafka']['connect_standalone']['logging_config_file_owner'] = 'root'
default['confluent']['kafka']['connect_standalone']['logging_config_file_mode']  = '0644'
default['confluent']['kafka']['connect_standalone']['logging_config_file']       = '/etc/kafka/connect-distributed.logging.properties'

default['confluent']['kafka']['connect_standalone']['log_dir']                        = '/var/log/kafka-connect-distributed'
default['confluent']['kafka']['connect_standalone']['log_dir_mode']                   = '0755'
default['confluent']['kafka']['connect_standalone']['service']                        = 'kafka-connect-distributed'
default['confluent']['kafka']['connect_standalone']['service_action']                 = [:enable, :start]
default['confluent']['kafka']['connect_standalone']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/kafka-connect-distributed.service'
      when 'rhel'
        '/usr/lib/systemd/system/kafka-connect-distributed.service'
    end
default['confluent']['kafka']['connect_standalone']['systemd_unit_mode']              = '0644'
default['confluent']['kafka']['connect_standalone']['systemd_unit_owner']             = 'root'
default['confluent']['kafka']['connect_standalone']['systemd_unit_group']             = 'root'
default['confluent']['kafka']['connect_standalone']['systemd_service_limitnofile']    = 1000
default['confluent']['kafka']['connect_standalone']['systemd_service_timeoutstopsec'] = 60


default['confluent']['kafka']['connect_standalone']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/kafka-connect-distributed'
      when 'rhel'
        '/etc/sysconfig/kafka-connect-distributed'
    end
default['confluent']['kafka']['connect_standalone']['environment_file_owner'] = 'root'
default['confluent']['kafka']['connect_standalone']['environment_file_group'] = 'root'
default['confluent']['kafka']['connect_standalone']['environment_file_mode']  = '0640'
default['confluent']['kafka']['connect_standalone']['heap_opts']              = '-Xmx1000M'
default['confluent']['kafka']['connect_standalone']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['kafka']['connect_standalone']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['kafka']['connect_standalone']['zookeeper_connect'] = 'localhost:2181'
default['confluent']['kafka']['connect_standalone']['config']            = {
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

default['confluent']['kafka']['connect_standalone']['logging_config'] = {
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