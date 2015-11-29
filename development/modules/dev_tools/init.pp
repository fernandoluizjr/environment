class dev_tools {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  Class['apt'] -> Package <| |>
}
