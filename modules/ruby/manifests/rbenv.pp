class ruby::rbenv {
  $rbenv_home='/home/vagrant/.rbenv'

  exec { 'rbenv-git':
    command => "/usr/bin/git clone https://github.com/rbenv/rbenv.git ${rbenv_home}",
    unless => "/bin/ls ${rbenv_home}",
    require => Package['git'],
  }

  exec { 'compile-rbenv':
    command => "${rbenv_home}/src/configure && /usr/bin/make -C src",
    cwd => "${rbenv_home}",
    unless => "/bin/ls ${rbenv_home}/libexec/rbenv-realpath.dylib", # make will generate this lib
    require => Exec['rbenv-git'],
  }

  file { '/etc/profile.d/append-rbenv-path.sh':
    mode => '0644',
    content => "PATH=${rbenv_home}/bin:\$PATH",
    require => Exec['compile-rbenv'],
  }
}
