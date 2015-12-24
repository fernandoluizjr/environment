class java::sdk {
  contain java::repo

  exec { "accept-license":
    command => "/bin/echo oracle-java8-installer \
			shared/accepted-oracle-license-v1-1 \
			select true | /usr/bin/debconf-set-selections",
    unless => "/usr/bin/debconf-get-selections \
			| /bin/grep oracle-java8-installer \
			| /bin/grep accepted-oracle-license-v1-1 \
			| /bin/grep select \
			| /bin/grep true",
  }

  package { "oracle-java8-installer":
    ensure => installed,
    require => [
                Exec["accept-license"],
                Class['java::repo'],
               ],
  }
}
