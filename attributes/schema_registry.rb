default['confluent']['schema_registry']['user']              = 'schema-registry'
default['confluent']['schema_registry']['config_file_owner'] = 'root'
default['confluent']['schema_registry']['config_file_mode']  = '0644'
default['confluent']['schema_registry']['config_file']       = '/etc/schema-registry/schema-registry.properties'

default['confluent']['schema_registry']['logging_config_file_owner'] = 'root'
default['confluent']['schema_registry']['logging_config_file_mode']  = '0644'
default['confluent']['schema_registry']['logging_config_file']       = '/etc/schema-registry/schema-registry.logging.properties'
default['confluent']['schema_registry']['log_dir']                        = '/var/log/schema-registry'
default['confluent']['schema_registry']['log_dir_mode']                   = '0755'
default['confluent']['schema_registry']['service']                        = 'schema-registry'
default['confluent']['schema_registry']['service_action']                 = [:enable, :start]
default['confluent']['schema_registry']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/schema-registry.service'
      when 'rhel'
        '/usr/lib/systemd/system/schema-registry.service'
    end
default['confluent']['schema_registry']['systemd_unit_mode']              = '0644'
default['confluent']['schema_registry']['systemd_unit_owner']             = 'root'
default['confluent']['schema_registry']['systemd_unit_group']             = 'root'
default['confluent']['schema_registry']['systemd_service_limitnofile']    = 65536
default['confluent']['schema_registry']['systemd_service_timeoutstopsec'] = 300


default['confluent']['schema_registry']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/schema-registry'
      when 'rhel'
        '/etc/sysconfig/schema-registry'
    end
default['confluent']['schema_registry']['environment_file_owner'] = 'root'
default['confluent']['schema_registry']['environment_file_group'] = 'root'
default['confluent']['schema_registry']['environment_file_mode']  = '0644'
default['confluent']['schema_registry']['heap_opts']              = '-Xmx1000M'
default['confluent']['schema_registry']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['schema_registry']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['schema_registry']['config'] = {
    'listeners'                 => 'http://0.0.0.0:8081',
    'kafkastore.topic'          => '_schemas',
    'debug'                     => false
}

default['confluent']['schema_registry']['logging_config'] = {
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