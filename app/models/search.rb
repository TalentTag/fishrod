class Search < ActiveRecord::Base

  scope :active, -> { where active: true }


  def pattern
    query # TODO utilize context & stopwords
  end

  def name
    super.presence || query[0..30] rescue 'Untitled'
  end

end
