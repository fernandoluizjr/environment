class loja_virtual::repo($baserepodir, $reponame) {

# Instala o gerenciador de repositorio de pacotes
  package { 'reprepro':
    ensure => 'installed',
  }

# Cria o diretorio raiz do gerenciador de repositorios
  $repo_structure = [
    "$baserepodir",
    "$baserepodir/conf",
  ]

  file { $repo_structure:
    ensure => 'directory',
    owner => 'jenkins',
    group => 'jenkins',
    require => Service['jenkins'],
  }

# Cria o arquivo de configuracao do gerenciador de repositorios
  file { "$baserepodir/conf/distributions":
    owner => 'jenkins',
    group => 'jenkins',
    content => template('loja_virtual/distributions.erb'),
    require => File["$baserepodir/conf"],
  }

# Cria um servidor apache para expor os releases via HTTP
  class { 'apache':
  }

  apache::vhost { "$reponame":
    port => 80,
    docroot => $baserepodir,
    servername => $ipaddress_eth1, #variavel do facter
  }

# Instala a rubygem FPM para criar pacotes .deb
  package { 'fpm':
    ensure => 'installed',
    provider => 'gem',
  }
}
