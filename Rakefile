# encoding: utf-8
require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

# ignore external forge modules syntax and code style validation
PuppetLint.configuration.ignore_paths = ["librarian/modules/**/*.pp"]

# moved from Rakefile created by rspec in a loop for all spec modules
TESTED_MODULES = %w(mysql)
namespace :spec do
  TESTED_MODULES.each do |module_name|
    desc "Roda os testes do módulo #{module_name}"
    RSpec::Core::RakeTask.new(module_name) do |t|
      t.pattern = "modules/#{module_name}/spec/**/*_spec.rb"
    end
  end
end

desc "Roda todos os testes"
task :spec => TESTED_MODULES.map {|m| "spec:#{m}" }

namespace :librarian do
  desc "Instala os modulos usando o Librarian Puppet"
  task :install do
    Dir.chdir('librarian') do
      sh "librarian-puppet install"
    end
  end
end

desc "Cria o pacote puppet.tgz"
task :package => ['librarian:install', :spec, :lint] do
# sh "tar czvf puppet.tgz manifests modules librarian/modules"
  sh "tar czvf puppet.tgz loja_virtual modules librarian/modules"
end

desc "Limpa o pacote puppet.tgz"
task :clean do
  sh "rm puppet.tgz"
end

task :default => [:spec, :lint]
