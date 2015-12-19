define git::config($user_name, $user_email, $core_editor) {

  exec { "global-user-name":
    unless => "git config --global --get user.name | /bin/grep '$user_name'",
    command => "git config --global user.name '$user_name'",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }

  exec { "global-user-email":
    unless => "git config --global --get user.email | /bin/grep '$user_email'",
    command => "git config --global user.email '$user_email'",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }

  exec { "global-core-editor":
    unless => "git config --global --get core.editor | /bin/grep '$core_editor'",
    command => "git config --global core.editor '$core_editor'",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }
}
