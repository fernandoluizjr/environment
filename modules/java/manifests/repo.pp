class java::repo {
  apt::ppa { 'ppa:webupd8team/java':
    package_manage => true,
  }
}
