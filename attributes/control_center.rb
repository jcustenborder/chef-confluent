#<> Control Center User: The username of the system account that will be created on the host machine. All data directories and log directories will be owned by this user.
default['confluent']['control_center']['user']              = 'control-center'
#<> Config file owner: The user that will own the configuration files.
default['confluent']['control_center']['config_file_owner'] = 'root'
#<> Config file mode: The permissions associated with the configuration file.
default['confluent']['control_center']['config_file_mode']  = '0644'
#<> Config file path: The location on the file system for the configuration file.
default['confluent']['control_center']['config_file']       = '/etc/confluent-control-center/control-center.properties'
#<> Logging Config file owner: The owner of the logging config file.
default['confluent']['control_center']['logging_config_file_owner'] = 'root'
#<> Logging Config file mode: The permissions associated with the logging configuration file.
default['confluent']['control_center']['logging_config_file_mode']  = '0644'
#<> Logging Config file path: The location on the file system for the logging configuration file.
default['confluent']['control_center']['logging_config_file']       = '/etc/confluent-control-center/control-center.logging.properties'
#<> Data Directory path: The location on the file system to store the data for Control Center.
default['confluent']['control_center']['data_dir']                       = '/var/lib/confluent-control-center'
#<> Data Directory Mode: The file system permissions associated with the data directory.
default['confluent']['control_center']['data_dir_mode']                  = '0755'
#<> Log Directory path: The location on the file system to store the logs for Control Center.
default['confluent']['control_center']['log_dir']                        = '/var/log/confluent-control-center'
#<> Data Directory Mode: The file system permissions associated with the log directory.
default['confluent']['control_center']['log_dir_mode']                   = '0755'
#<> Service Name: The name of the service in SystemD.
default['confluent']['control_center']['service']                        = 'confluent-control-center'
#<> Service Action: Actions for the service.
default['confluent']['control_center']['service_action']                 = [:enable, :start]
#<> SystemD Unit path: The location for the SystemD unit.
default['confluent']['control_center']['systemd_unit']                   =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system/confluent-control-center.service'
      when 'rhel'
        '/usr/lib/systemd/system/confluent-control-center.service'
    end
#<> Limits.d conf path: The location of the limits.d config for Control Center.
default['confluent']['control_center']['file_limit_config']              = '/etc/security/limits.d/99-confluent-control-center.config'
#<> File limit: The maximum number of file handles that Control Center will be allowed to open
default['confluent']['control_center']['file_limit']                     = 100000
#<> SystemD file mode: The permissions for the SystemD Unit on the filesystem.
default['confluent']['control_center']['systemd_unit_mode']              = '0644'
#<> SystemD file owner: The owner for the SystemD Unit on the filesystem.
default['confluent']['control_center']['systemd_unit_owner']             = 'root'
#<> SystemD file group: The group for the SystemD Unit on the filesystem.
default['confluent']['control_center']['systemd_unit_group']             = 'root'
#<> SystemD TimeoutStopSec: The amount of time for SystemD to wait for the process to stop. This should be a considerable amount of time to allow the process to exit cleanly and prevent corruption.
default['confluent']['control_center']['systemd_service_timeoutstopsec'] = 300
#<> SystemD EnvironmentFile: The path to the file containing environment variables that will be used when the application is started.
default['confluent']['control_center']['environment_file']       =
    case node['platform_family']
      when 'debian'
        '/etc/default/confluent-control-center'
      when 'rhel'
        '/etc/sysconfig/confluent-control-center'
    end
#<> SystemD EnvironmentFile owner: The owner for the SystemD EnvironmentFile.
default['confluent']['control_center']['environment_file_owner'] = 'root'
#<> SystemD EnvironmentFile group: The group for the SystemD EnvironmentFile.
default['confluent']['control_center']['environment_file_group'] = 'root'
#<> SystemD EnvironmentFile mode: The filesystem permissions for the SystemD EnvironmentFile.
default['confluent']['control_center']['environment_file_mode']  = '0644'
#<> Java heap options: The amount of heap the process should be started with.
default['confluent']['control_center']['heap_opts']              = '-Xmx1000M'
#<> Java additional options: Additional options that can be passed to the java process. This is where Kerberos and JAAS files should be specified.
default['confluent']['control_center']['kafka_opts']             = '-Djava.net.preferIPv4Stack=true'
#<> Java additional options: Additional options that can be passed to the java process. This is where Kerberos and JAAS files should be specified.
default['confluent']['control_center']['environment_config'] = {
    'GC_LOG_ENABLED' => true,
}
#<> Control Center configuration options: Configuration options that will be placed in the config file.
default['confluent']['control_center']['config'] = {
    'confluent.controlcenter.streams.num.stream.threads' => [8, node['cpu']['total'].to_i].max,
}
#<> Control Center logging config: Logging configuration for log4j.
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