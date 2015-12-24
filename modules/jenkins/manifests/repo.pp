class jenkins::repo {
  apt::source { 'jenkins-repo':
    location => 'http://pkg.jenkins-ci.org/debian',
    release => 'binary/',
    repos => '',
    key => {
      id => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
      source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    },
  }
}
