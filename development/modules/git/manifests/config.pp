define git::config($global) {

  exec { "global-user-name":
    unless => "git config --global --get user.name | /bin/grep \"${global[user_name]}\"",
    command => "git config --global user.name \"${global[user_name]}\"",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }

  exec { "global-user-email":
    unless => "git config --global --get user.email | /bin/grep \"${global[user_email]}\"",
    command => "git config --global user.email \"${global[user_email]}\"",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }

  exec { "global-core-editor":
    unless => "git config --global --get core.editor | /bin/grep \"${global[core_editor]}\"",
    command => "git config --global core.editor \"${global[core_editor]}\"",
    environment => "HOME=/home/vagrant",
    path => "/usr/bin/",
  }
}
