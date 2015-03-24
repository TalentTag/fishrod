class Fetch < Thor

  desc "vk", "fetch data from VK"
  def vk
    init!
    client = VkontakteApi::Client.new
    entries = client.newsfeed.search(q: 'ищу работу', extended: 1)[1..-1]
    entries.each do |entry|
      entry = Entry.new({
        body: entry.text,
        url: "https://vk.com/wall#{ entry.owner_id }_#{ entry.id }",
        source: 'vk',
        author: entry.user || entry.group,
        created_at: entry.date,
        fetched_at: Time.now
      })
      print '.' if entry.save
    end
  end

  desc "facebook", "fetch data from Facebook"
  def facebook
    init!
    entries = FbGraph::Searchable.search("ищу работу", access_token: '778009828890303|iTspplsW8M4vHaJiCM6XtqVYvts') # TODO obtain access token
    entries.each do |entry|
      owner_id, post_id = entry['id'].split('_')
      pp entry unless entry['message']
      entry = Entry.new({
        body: entry['message'],
        url: "https://www.facebook.com/#{ owner_id }/posts/#{ post_id }",
        source: 'facebook',
        author: entry['from'],
        created_at: entry['created_time'],
        fetched_at: Time.now
      })
      begin
        print '.' if entry.save # TODO validate
      rescue
      end
    end
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
