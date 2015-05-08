class Process < Thor

  require File.expand_path("config/environment.rb") unless defined?(Rails)


  desc 'all', 'Process all stored entries'
  def all
    # TODO optimize: look in new entries only
    ids = Entry.search_for_ids('="ищу работу" | ="ищет работу" | ="ищем работу"', order: 'created_at DESC')
    Entry.where(id: ids).update_all state: 1
    system "bundle exec rake ts:index"
  end


  default_task :all

end
