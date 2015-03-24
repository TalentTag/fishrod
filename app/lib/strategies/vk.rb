class Strategies::Vk

  def self.fetch
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
      entry.save # TODO validate
    end
  end

end
