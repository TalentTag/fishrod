class Strategies::Vk

  def self.fetch
    client = VkontakteApi::Client.new
    entries = client.newsfeed.search(q: 'ищу работу', extended: 1)[1..-1]
    entries.each do |hash|
      entry = Entry.new({
        body: hash.text,
        url: "https://vk.com/wall#{ hash.owner_id }_#{ hash.id }",
        source_id: 1,
        author: hash.user || hash.group,
        created_at: hash.date,
        fetched_at: Time.now,
        raw_data: hash
      })
      entry.save # TODO validate
    end
  end

end
