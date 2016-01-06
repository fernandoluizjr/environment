require File.join(File.dirname(__FILE__), '..', 'spec_helper')

# descreve a classe define ou funcao que iremos testar
describe 'mysql::client' do
  it { # cada bloco it representa um caso de teste
    should contain_package('mysql-client').
      with_ensure('installed')
  }
end
