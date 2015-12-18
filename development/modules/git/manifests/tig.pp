class git::tig {
  include git::git

  package { "tig":
    ensure => installed,
    require => Package["git"],
  }
}
