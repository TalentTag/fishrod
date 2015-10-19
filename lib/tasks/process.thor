class Process < Thor

  require File.expand_path("config/environment.rb") unless defined?(Rails)


  desc 'all', 'Process all stored entries'
  def all
  	logger.info 'processing: start'
    # TODO optimize: look in new entries only
    ids = Entry.search_for_ids('="ищу работу" | ="ищет работу" | ="ищу подработку" | ="ищет подработку"', order: 'fetched_at DESC', with: { state: State::RAW })
    Entry.where(id: ids).update_all state: 1
    system "bundle exec rake ts:index"
    logger.info "processing: #{ ids.to_a.count } entries marked"
  end


  default_task :all


  private

  def logger
    @logger ||= Logger.new("#{ Rails.root }/log/thor.log")
  end

end
