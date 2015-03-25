server '178.62.200.27', user: 'rbdev', roles: %w{web app}
set :user, 'rbdev'
set :deploy_to, "/var/www/#{ fetch :application }"
set :env, :staging
