confluent_version = '4.0'
default['confluent']['repository_url'] =
    case node['platform_family']
      when 'debian'
        "http://packages.confluent.io/deb/#{confluent_version}"
      when 'rhel'
        "http://packages.confluent.io/rpm/#{confluent_version}"
    end
default['confluent']['key_url'] =
    case node['platform_family']
      when 'debian'
        "http://packages.confluent.io/deb/#{confluent_version}/archive.key"
      when 'rhel'
        "http://packages.confluent.io/rpm/#{confluent_version}/archive.key"
    end
default['confluent']['dist_repository_url'] = "http://packages.confluent.io/rpm/#{confluent_version}/7"
default['confluent']['gpg_check'] = true
default['confluent']['repo_enabled'] = true
default['confluent']['package'] = 'confluent-platform-2.11'
default['confluent']['manage_repo'] = true
default['confluent']['systemd_dir'] =
    case node['platform_family']
      when 'debian'
        '/lib/systemd/system'
      when 'rhel'
        '/usr/lib/systemd/system'
    end
default['confluent']['environment_dir'] =
    case node['platform_family']
      when 'debian'
        '/etc/default'
      when 'rhel'
        '/etc/sysconfig'
    end

