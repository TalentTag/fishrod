class Fetch < Thor

  require File.expand_path("config/environment.rb") unless defined?(Rails)


  desc "vk", "fetch data from VK"
  def vk skip_index=false
    logger.info 'fetching: start'
    entries = Strategies::Vk.fetch
    reindex! unless skip_index
  end
  default_task :vk


  private

  def reindex!
    system "bundle exec rake ts:index"
  end

  def logger
    @logger ||= Logger.new("#{ Rails.root }/log/thor.log")
  end

end
