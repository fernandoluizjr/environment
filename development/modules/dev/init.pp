class dev {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  Class['apt'] -> Package <| |>
}
