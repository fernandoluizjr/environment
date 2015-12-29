class loja_virtual::repo($basedir, $reponame) {

# Instala o gerenciador de repositorio de pacotes
  package { 'reprepro':
    ensure => 'installed',
  }

# Cria o diretorio raiz do gerenciador de repositorios
  $repo_structure = [
    "$basedir",
    "$basedir/conf",
  ]

  file { $repo_structure:
    ensure => 'directory',
    owner => 'jenkins',
    group => 'jenkins',
    require => Service['jenkins'],
  }

# Cria o arquivo de configuracao do gerenciador de repositorios
  file { "$basedir/conf/distributions":
    owner => 'jenkins',
    group => 'jenkins',
    content => template('loja_virtual/distributions.erb'),
    require => File["$basedir/conf"],
  }

# Cria um servidor apache para expor os releases via HTTP
  class { 'apache':
  }

  apache::vhost { "$reponame":
    port => 80,
    docroot => $basedir,
    servername => $ipaddress_eth1, #variavel do facter
  }
}
