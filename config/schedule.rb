set :output, "#{path}/log/cron.log"

job_type :thor, "cd #{path}; :environment_variable=:environment bundle exec thor :task :output"

every 5.minutes do
  thor "fetch"
end
