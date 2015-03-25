class Entry < ActiveRecord::Base

  scope :by_source, ->(source){ where(source: source) }
  default_scope ->{ limit(20) }

  validate :unique_body


  protected

  def unique_body
    !Entry.exists?(body: body)
  end

end
