default['confluent']['schema_registry_user'] = 'schema-registry'
default['confluent']['schema_registry_data_dir'] = '/var/lib/schema-registry'
default['confluent']['schema_registry_log_dir'] = '/var/log/schema-registry'
default['confluent']['schema_registry_service'] = 'schema-registry'
default['confluent']['schema_registry_systemd_unit'] = File.join(
    default['confluent']['systemd_dir'],
    "#{default['confluent']['schema_registry_service']}.service"
)
default['confluent']['schema_registry_environment_file'] = File.join(
    default['confluent']['environment_dir'],
    default['confluent']['schema_registry_service']
)