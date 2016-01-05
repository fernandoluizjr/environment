# encoding: utf-8
require 'puppet-lint/tasks/puppet-lint'

# ignore external forge modules syntax and code style validation
PuppetLint.configuration.ignore_paths = ["librarian/modules/**/*.pp"]

namespace :librarian do
  desc "Instala os modulos usando o Librarian Puppet"
  task :install do
    Dir.chdir('librarian') do
      sh "librarian-puppet install"
    end
  end
end

desc "Cria o pacote puppet.tgz"
task :package => ['librarian:install', :lint] do
# sh "tar czvf puppet.tgz manifests modules librarian/modules"
  sh "tar czvf puppet.tgz loja_virtual modules librarian/modules"
end

desc "Limpa o pacote puppet.tgz"
task :clean do
  sh "rm puppet.tgz"
end
