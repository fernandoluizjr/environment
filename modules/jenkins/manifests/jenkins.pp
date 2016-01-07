class jenkins::jenkins {
  require jenkins::repo

  package { 'jenkins':
    require => [
                Class['jenkins::repo'],
                Class['apt::update'],
    ],
  }

  service { 'jenkins':
    ensure => 'running',
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package['jenkins'],
  }
}
