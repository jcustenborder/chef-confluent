default['confluent']['control_center']['user']              = 'control-center'
default['confluent']['control_center']['config_file_owner'] = 'root'
default['confluent']['control_center']['config_file_mode']  = '0644'
default['confluent']['control_center']['config_file']       = '/etc/confluent-control-center/control-center.properties'

default['confluent']['control_center']['logging_config_file_owner'] = 'root'
default['confluent']['control_center']['logging_config_file_mode']  = '0644'
default['confluent']['control_center']['logging_config_file']       = '/etc/confluent-control-center/control-center.logging.properties'

default['confluent']['control_center']['data_dir']                       = '/var/lib/confluent-control-center'
default['confluent']['control_center']['data_dir_mode']                  = '0755'
default['confluent']['control_center']['log_dir']                        = '/var/log/confluent-control-center'
default['confluent']['control_center']['log_dir_mode']                   = '0755'
default['confluent']['control_center']['service']                        = 'confluent-control-center'
default['confluent']['control_center']['service_action']                 = [:enable, :start]
default['confluent']['control_center']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/zookeeper.service'
      when 'rhel'
        '/usr/lib/systemd/system/zookeeper.service'
    end
default['confluent']['control_center']['systemd_unit_mode']              = '0644'
default['confluent']['control_center']['systemd_unit_owner']             = 'root'
default['confluent']['control_center']['systemd_unit_group']             = 'root'
default['confluent']['control_center']['systemd_service_limitnofile']    = 65536
default['confluent']['control_center']['systemd_service_timeoutstopsec'] = 300


default['confluent']['control_center']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/zookeeper'
      when 'rhel'
        '/etc/sysconfig/zookeeper'
    end
default['confluent']['control_center']['environment_file_owner'] = 'root'
default['confluent']['control_center']['environment_file_group'] = 'root'
default['confluent']['control_center']['environment_file_mode']  = '0644'
default['confluent']['control_center']['heap_opts']              = '-Xmx1000M'
default['confluent']['control_center']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'

default['confluent']['control_center']['environment_config'] = {
    'KAFKA_OPTS'     => '-Djava.net.preferIPv4Stack=true',
    'GC_LOG_ENABLED' => true,
}

default['confluent']['control_center']['config'] = {
    'confluent.controlcenter.streams.num.stream.threads' => [8, node['cpu']['total'].to_i].max,
}

default['confluent']['control_center']['logging_config'] = {
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