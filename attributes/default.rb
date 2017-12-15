#<> YUM repository url: Location to pull the packages from.
default['confluent']['yum_repository_url'] = "http://packages.confluent.io/rpm/4.0"
#<> YUM dist repository url: Location to pull the packages from. This is additional packages that are specific to EL7
default['confluent']['yum_dist_repository_url'] = "http://packages.confluent.io/rpm/4.0/7"
#<> YUM GPG Key Url: Location of the GPG key for the YUM repositories.
default['confluent']['yum_key_url'] = "http://packages.confluent.io/rpm/4.0/archive.key"
#<> APT Repository Url: Base location for the apt repository.
default['confluent']['apt_repository_url'] = "http://packages.confluent.io/deb/4.0"
#<> APT Key Url: Location of the GPG key the packages were signed with.
default['confluent']['apt_key_url']  = "http://packages.confluent.io/deb/4.0/archive.key"
#<> GPG Check: Should the package manager check for the GPG signatures.
default['confluent']['gpg_check']    = true
#<> Repository Enabled: Flag to determine if the repository should be enabled.
default['confluent']['repo_enabled'] = true
#<> Package to install: Installation package that will be used to install the Confluent Platform.
default['confluent']['package']      = 'confluent-platform-2.11'
#<> Manage Repository: Flag to determine if the repository should be managed on the host machine.
default['confluent']['manage_repo']  = true
