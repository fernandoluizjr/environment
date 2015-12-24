# Juntando essas duas instrucoes numa classe temos um codigo mais
# generico que garante que o Puppet ira executar um apt-get update
# antes de tentar instalar qualquer pacote no sistema.

class loja_virtual {

# Com isso, garantimos que o Puppet ira rodar o comando
# apt-get update toda vez que for executado. No entanto,
# precisamos garantir que o comando rode antes da
# instalacao de qualquer pacote no sistema

# class { 'apt':
#   update => {
#     frequency => 'always',
#   },
# }

# A flecha -> impoe uma restricao na ordem de execucao dos recursos.
# Da mesma forma que o parametro require indica uma dependencia entre
# dois recursos, a flecha -> garante que o recurso do lado esquerdo -
# nesse caso a classe apt - seja executado antes do recurso do lado
# direito. A sintaxe <| |> eh um coletor de recursos. O coletor
# representa um grupo de recursos e eh composto de: um tipo de recurso,
# o operador <|, uma expressao de busca opcional e o operador |>.
# Como deixamos a expressao de busca em branco, selecionamos todos os
# recursos do tipo package.

# Class['apt'] -> Package <| |>

# Outro exemplo:
# Class['apt::update'] -> Package<| |>
}
