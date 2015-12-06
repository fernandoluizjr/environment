class development {

# Ensure that add-apt-repository binary is present
# because some packages needs add PPA repositories
  package { "python-software-properties":
    ensure => installed,
  }

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  Class['apt'] -> Package <| |>
}
