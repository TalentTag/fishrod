class Strategies::Facebook

  def self.fetch
    entries = FbGraph::Searchable.search("ищу работу", access_token: '778009828890303|iTspplsW8M4vHaJiCM6XtqVYvts') # TODO obtain access token
    entries.each do |entry|
      owner_id, post_id = entry['id'].split('_')
      entry = Entry.new({
        body: entry['message'],
        url: "https://www.facebook.com/#{ owner_id }/posts/#{ post_id }",
        source_id: SourceMap.all[:facebook],
        author: entry['from'],
        created_at: entry['created_time'],
        fetched_at: Time.now
      })
      entry.save rescue nil # TODO validate
    end
  end

end
