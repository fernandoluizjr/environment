class development::git {
  include development
  include development::params
  include git::tig

  git::config { "git-config":
    global => $development::params::git_config_global,
  }
}
