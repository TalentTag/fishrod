server '159.203.102.151', user: 'rbdev', roles: %w{web app}
set :user, 'rbdev'
set :deploy_to, "/var/www/#{ fetch :application }"
set :env, :staging
