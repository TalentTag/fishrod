class Process < Thor

  require File.expand_path("config/environment.rb") unless defined?(Rails)


  desc 'all', 'Process all stored entries'
  def all
    Search.active.each do |search|
      ids = Entry.search_for_ids(search.pattern, order: 'fetched_at DESC', with: { state: State::RAW }, limit: 100)
      Entry.where(id: ids).update_all state: State::PROCESSED
      logger.info "processing: '#{ search.pattern }' --- #{ ids.to_a.count } entries"
    end
    system "bundle exec rake ts:index"
  end


  default_task :all


  private

  def logger
    @logger ||= Logger.new("#{ Rails.root }/log/thor.log")
  end

end
