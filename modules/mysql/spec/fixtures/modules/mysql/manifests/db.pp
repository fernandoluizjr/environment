# Um tipo definido eh uma colecao de recursos que pode ser usada
# varias vezes em um mesmo manifesto. Eles permitem que vc elimine
# duplicacao de codigo agrupando recursos relacionados que podem ser
# reutilizados em conjunto. Voce pode interpreta-los como equivalentes
# a macros em uma linguagem de programacao. Alem disso, eles podem ser
# parametrizados e definir valores padrao para parametros opcionais.
# No caso abaixo o parametro $user, quando nao especificado, tera o
# mesmo valor do parametro especial $title.

# $title eh um parametro especial pq nao precisa ser passado
# explicitamente. O nome do recurso que instancia o tipo definido,
# neste caso loja, sera passado como valor do parametro $title.
define mysql::db($schema, $user = $title, $password) {

# A flecha -> impoe uma restricao na ordem de execucao dos recursos.
# Da mesma forma que o parametro require indica uma dependencia entre
# dois recursos, a flecha -> garante que o recurso do lado esquerdo
# seja executado antes do recurso do lado direito.
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
