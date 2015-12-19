define git::config($global) {

  $global.each |$key, $val| {
    exec { "git-config-global-$key":
      unless => "git config --global --get $key | /bin/grep \"$val\"",
      command => "git config --global $key \"$val\"",
      environment => "HOME=/home/vagrant",
      path => "/usr/bin/",
    }
  }
}
