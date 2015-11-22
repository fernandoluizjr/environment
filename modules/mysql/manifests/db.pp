# Um tipo definido eh uma colecao de recursos que pode ser usada
# varias vezes em um mesmo manifesto. Eles permitem que vc elimine
# duplicacao de codigo agrupando recursos relacionados que podem ser
# reutilizados em conjunto. Voce pode interpreta-los como equivalentes
# a macros em uma linguagem de programacao. Alem disso, eles podem ser
# parametrizados e definir valores padrao para parametros opcionais.

define mysql::db($schema, $user = $title, $password) {
  Class['mysql::server'] -> Mysql::Db[$title]

  exec { "$title-schema":
    unless => "mysql -uroot $schema",
    command => "mysqladmin -uroot create $schema",
    path => "/usr/bin/",
  }

  exec { "$title-user":
    unless => "mysql -u$user -p$password $schema",
    command => "mysql -uroot -e \"GRANT ALL PRIVILEGES ON \
		$schema.* TO '$user'@'%' IDENTIFIED BY '$password';\"",
    path => "/usr/bin/",
    require => Exec["$title-schema"],
  }
}
