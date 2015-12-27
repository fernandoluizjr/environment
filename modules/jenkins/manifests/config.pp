define jenkins::config ($value) {
  $value.each |$key, $val| {
    file_line { "jenkins-config-global-${key}":
      path   => "/etc/default/jenkins",
      line   => "${key}=\"${val}\"",
      match  => "^${key}=",
      require => Package['jenkins'],
      notify => Service['jenkins'],
    }
  }
}
