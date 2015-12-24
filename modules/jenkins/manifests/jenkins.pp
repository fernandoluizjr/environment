class jenkins::jenkins {
  contain jenkins::repo

  package { 'jenkins-package':
    require => Class['jenkins::repo'],
  }

  service { 'jenkins':
    ensure => 'running',
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package['jenkins-package'],
  }
}
