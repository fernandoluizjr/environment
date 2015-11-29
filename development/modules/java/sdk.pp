class java::sdk {

  apt::ppa { 'ppa:webupd8team/java': }

  exec { "accept-license":
    command => "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 \
				select true | sudo /usr/bin/debconf-set-selections",
    path => "/usr/bin",
  }

  package { "oracle-java8-installer":
    ensure => installed,
  }
}
