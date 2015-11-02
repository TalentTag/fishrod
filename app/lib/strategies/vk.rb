class Strategies::Vk

  ENTRIES_TO_FETCH_LIMIT = 500

  def self.fetch
    client = VkontakteApi::Client.new
    saved_entries = []
    entries = client.newsfeed.search(q: 'ищу работу', extended: 1, count: ENTRIES_TO_FETCH_LIMIT)[1..-1]
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
      saved_entries << entry if entry.save
    end
    saved_entries
  end

end
