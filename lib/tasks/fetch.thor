class Fetch < Thor

  desc "vk", "fetch data from VK"
  def vk
    init!
    Strategies::Vk.fetch
  end

  desc "facebook", "fetch data from Facebook"
  def facebook
    init!
    Strategies::Facebook.fetch
  end


  desc "all", "fetch entries"
  def all
    vk && facebook
  end
  default_task :all


  private

  def init!
    require File.expand_path("config/environment.rb") unless defined?(Rails)
  end

end
