class Fetch < Thor

  require File.expand_path("config/environment.rb") unless defined?(Rails)


  desc "vk", "fetch data from VK"
  def vk skip_index=false
    Strategies::Vk.fetch
    reindex! unless skip_index
  end

  desc "facebook", "fetch data from Facebook"
  def facebook skip_index=false
    Strategies::Facebook.fetch
    reindex! unless skip_index
  end


  desc "all", "fetch entries"
  def all
    vk(:skip_index) && facebook(:skip_index)
    reindex!
  end
  default_task :all


  private

  def reindex!
    system "bundle exec rake ts:index"
  end

end
