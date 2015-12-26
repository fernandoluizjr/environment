define jenkins::plugins($plugins) {
  $plugin_dir = '/var/lib/jenkins/plugins'
  $plugins_host = 'https://updates.jenkins-ci.org'
  $base_url = "${plugins_host}/latest/"

  file { "$plugin_dir":
    ensure => 'directory',
    owner => 'jenkins',
    group => 'jenkins',
    mode => '0644',
    require => Package['jenkins'],
  }

  $plugins.each |$plugin_name| {
    $download_url = "${base_url}${plugin_name}.hpi"
    $plugin_ext = regsubst($download_url, '^.*\.(hpi|jpi)$', '\1')
    $plugin = "${plugin_name}.${plugin_ext}"

    exec { "$plugin":
      command => "/usr/bin/wget -qO ${plugin_dir}/${plugin} $download_url",
      notify => Service['jenkins'],
      require => File["$plugin_dir"],
    }

    file { "${plugin_dir}/${plugin}":
      ensure => 'file',
      owner => 'jenkins',
      group => 'jenkins',
      mode => '0644',
      require => Exec["$plugin"],
    }

    file { "${plugin_dir}/${plugin}.pinned":
      ensure => 'file',
      owner => 'jenkins',
      group => 'jenkins',
      mode => '0644',
      require => File["${plugin_dir}/${plugin}"],
    }
  }
}
