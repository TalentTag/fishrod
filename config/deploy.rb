require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'
require 'mina/whenever'

set :domain, '159.203.102.151'
set :application, 'fishrod'
set :user, 'rbdev'
set :deploy_to, "/var/www/#{application}"
set :repository, 'git@github.com:TalentTag/fishrod-sphinx.git'
set :branch, 'master'
set :forward_agent, true

set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'tmp']

task :environment do
  invoke :'rbenv:load'
end


task setup: :environment do
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids")
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]
  queue %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids")
end


task deploy: :environment do
  to :before_hook do
  end

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'whenever:update'
      invoke :'puma:phased_restart'
    end
  end
end
