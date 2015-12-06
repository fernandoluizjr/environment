class java::sdk {

#  exec { "purge-old-java":
#    command => "apt-get purge openjdk*"
#  }

  apt::ppa { 'ppa:webupd8team/java': }

#  exec { "accept-license":
#    command => "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 \
#				select true | /usr/bin/debconf-set-selections",
#    path => "/usr/bin",
#  }

  package { "oracle-java8-installer":
    ensure => installed,
  }
}
