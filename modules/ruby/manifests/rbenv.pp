class ruby::rbenv {
  $rbenv_home='/home/vagrant/.rbenv'

  exec { 'rbenv-git':
    command => "/usr/bin/git clone https://github.com/rbenv/rbenv.git ${rbenv_home}",
    user => 'vagrant',
    group => 'vagrant',
    unless => "/bin/ls ${rbenv_home}",
    require => Package['git'],
  }

  exec { 'compile-rbenv':
    command => "${rbenv_home}/src/configure && /usr/bin/make -C src",
    user => 'vagrant',
    group => 'vagrant',
    cwd => "${rbenv_home}",
    unless => "/bin/ls ${rbenv_home}/libexec/rbenv-realpath.dylib", # make will generate this lib
    require => Exec['rbenv-git'],
  }

  file { '/etc/profile.d/append-rbenv-path.sh':
    mode => '0644',
    content => "PATH=${rbenv_home}/bin:\$PATH\neval \"\$(rbenv init -)\"\n",
    require => Exec['compile-rbenv'],
  }

  exec { 'ruby-build-git':
    command => "/usr/bin/git clone https://github.com/rbenv/ruby-build.git ${rbenv_home}/plugins/ruby-build",
    user => 'vagrant',
    group => 'vagrant',
    unless => "/bin/ls ${rbenv_home}/plugins/ruby-build",
    require => Exec['rbenv-git'],
  }
}
