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
