class maven::maven {
  $maven_base_url='http://ftp.unicamp.br/pub/apache/maven/maven-3'
  $maven_version='3.3.9'
  $maven_archive='apache-maven'
  $maven_ext='bin.tar.gz'
  $maven_package="$maven_archive-$maven_version-$maven_ext"

  exec { 'download-maven':
    command => "/usr/bin/wget -q $maven_base_url/$maven_version/binaries/$maven_package",
	cwd => '/tmp',
    unless => '/usr/bin/which mvn'
  }

  exec { 'unpack-maven':
    command => "/bin/gunzip -c /tmp/$maven_package | /bin/tar -xf-",
	cwd => '/opt',
	unless => "/bin/ls /opt/$maven_archive-$maven_version",
    require => Exec['download-maven'],
  }

  file { '/etc/profile.d/append-maven-path.sh':
    mode => '0644',
    content => "PATH=\$PATH:/opt/$maven_archive-$maven_version/bin",
  }

  file { '/usr/share/maven':
    ensure => 'link',
    target => "/opt/$maven_archive-$maven_version",
  }
}
