default['confluent']['zookeeper']['user']              = 'zookeeper'
default['confluent']['zookeeper']['config_file_owner'] = 'root'
default['confluent']['zookeeper']['config_file_mode']  = '0644'
default['confluent']['zookeeper']['config_file']       = '/etc/kafka/zookeeper.properties'

default['confluent']['zookeeper']['logging_config_file_owner'] = 'root'
default['confluent']['zookeeper']['logging_config_file_mode']  = '0644'
default['confluent']['zookeeper']['logging_config_file']       = '/etc/kafka/zookeeper.logging.properties'

default['confluent']['zookeeper']['data_dir']                       = '/var/lib/zookeeper'
default['confluent']['zookeeper']['data_dir_mode']                  = '0755'
default['confluent']['zookeeper']['log_dir']                        = '/var/log/zookeeper'
default['confluent']['zookeeper']['log_dir_mode']                   = '0755'
default['confluent']['zookeeper']['service']                        = 'zookeeper'
default['confluent']['zookeeper']['service_action']                 = [:enable, :start]
default['confluent']['zookeeper']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/zookeeper.service'
      when 'rhel'
        '/usr/lib/systemd/system/zookeeper.service'
    end
default['confluent']['zookeeper']['file_limit_config']              = '/etc/security/limits.d/99-confluent-zookeeper.config'
default['confluent']['zookeeper']['file_limit']                     = 65535
default['confluent']['zookeeper']['systemd_unit_mode']              = '0644'
default['confluent']['zookeeper']['systemd_unit_owner']             = 'root'
default['confluent']['zookeeper']['systemd_unit_group']             = 'root'
default['confluent']['zookeeper']['systemd_service_timeoutstopsec'] = 300


default['confluent']['zookeeper']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/zookeeper'
      when 'rhel'
        '/etc/sysconfig/zookeeper'
    end
default['confluent']['zookeeper']['environment_file_owner'] = 'root'
default['confluent']['zookeeper']['environment_file_group'] = 'root'
default['confluent']['zookeeper']['environment_file_mode']  = '0644'
default['confluent']['zookeeper']['heap_opts']              = '-Xmx1000M'
default['confluent']['zookeeper']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['zookeeper']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['zookeeper']['config'] = {
    'clientPort'                => 2181,
    'maxClientCnxns'            => 0,
    'initLimit'                 => 5,
    'syncLimit'                 => 2,
    'autopurge.snapRetainCount' => 10,
    'autopurge.purgeInterval'   => 1,
}

default['confluent']['zookeeper']['logging_config'] = {
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