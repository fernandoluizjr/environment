class loja_virtual::ci {
  include loja_virtual
  include java::sdk
  include git::git
  include maven::maven
  include jenkins::jenkins
  include loja_virtual::params

  git::config { 'git-config':
    global => $loja_virtual::params::git_config_global,
  }

  jenkins::plugins { 'jenkins-plugins':
    plugins => $loja_virtual::params::jenkins_plugins,
  }
}
