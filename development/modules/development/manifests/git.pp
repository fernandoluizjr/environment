class development::git {
  include development
  include development::params
  include git::tig

  git::config { "git-config":
    user_name => $development::params::git_config_global[user_name],
    user_email => $development::params::git_config_global[user_email],
    core_editor => $development::params::git_config_global[core_editor],
  }
}
