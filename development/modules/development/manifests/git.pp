class development::git {
  include development
  include git::tig
  include development::params

  git::config { "git-config":
    global => $development::params::git_config_global,
  }
}
