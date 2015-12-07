class development {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  Class['apt'] -> Package <| |>
}
