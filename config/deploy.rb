set :application, 'fishrod'
set :repo_url, 'git@github.com:TalentTag/fishrod.git'
set :scm, :git

set :pty, true
set :keep_releases, 5
set :deploy_via, :remote_cache
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey)
}

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# set :rbenv_roles, :all # default value

namespace :deploy do
  after :publishing, :restart
  after :restart, :cleanup
end


namespace :admin do
  desc "Tail log file"
  task :log do
    on roles :app do
      execute("tail", "-f #{shared_path}/log/#{ fetch :stage }.log") do |channel, stream, data|
        puts "#{channel[:host]}: #{data}" if stream == :out
        warn "[err :: #{channel[:server]}] #{data}" if stream == :err
      end
    end
  end
end
