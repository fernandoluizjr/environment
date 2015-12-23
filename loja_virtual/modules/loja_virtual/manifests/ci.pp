class loja_virtual::ci {
  include loja_virtual
  include git::git
  include maven::maven
  include java::sdk
  include loja_virtual::params

  git::config { "git-config":
    global => $loja_virtual::params::git_config_global,
  }
}
