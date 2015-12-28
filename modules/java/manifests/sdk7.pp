class java::sdk7 {
  require java::repo

  exec { 'accept-java7-license':
    command => "/bin/echo oracle-java7-installer \
			shared/accepted-oracle-license-v1-1 \
			select true | /usr/bin/debconf-set-selections",
    unless => "/usr/bin/dpkg -l | grep oracle-java7-installer",
  }

  package { 'oracle-java7-installer':
    ensure => installed,
    require => [
                Exec['accept-java7-license'],
                Class['apt::update'],
               ],
  }
}
