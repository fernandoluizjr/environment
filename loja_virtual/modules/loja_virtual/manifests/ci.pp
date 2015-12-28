class loja_virtual::ci {
  include loja_virtual
  include java::sdk7
  include git::git
  include maven::maven
  include jenkins::jenkins
  include loja_virtual::params

  git::config { 'git-config':
    global => $loja_virtual::params::git_config_global,
  }

  jenkins::config { 'jenkins-config':
    value => $loja_virtual::params::jenkins_config,
  }

  jenkins::plugins { 'jenkins-plugins':
    plugins => $loja_virtual::params::jenkins_plugins,
  }

  file { '/var/lib/jenkins/hudson.tasks.Maven.xml':
    mode => '0644',
    owner => 'jenkins',
    group => 'jenkins',
    source => 'puppet:///modules/loja_virtual/hudson.tasks.Maven.xml',
    require => Package['jenkins'],
    notify => Service['jenkins'],
  }

  $job_structure = [
    '/var/lib/jenkins/jobs/',
    '/var/lib/jenkins/jobs/loja-virtual-devops'
  ]

  $project_repository_url = 'https://github.com/fernandoluizjr/loja-virtual-devops'
  $repository_poll_interval = '* * * * *'
  $maven_goal = 'install'
  $archive_artifacts = 'combined/target/*.war'

  file { $job_structure:
    ensure => 'directory',
    owner => 'jenkins',
    group => 'jenkins',
    require => Package['jenkins'],
  }

  file { "${job_structure[1]}/config.xml":
    mode => '0644',
    owner => 'jenkins',
    group => 'jenkins',
    content => template('loja_virtual/config.xml'),
    require => File[$job_structure],
    notify => Service['jenkins'],
  }
}
