class Search < ActiveRecord::Base

  def name
    super || query[0..30] rescue nil
  end

end
