class Entry < ActiveRecord::Base

  scope :by_source, ->(source){ where(source: source) }

  validate :unique_body

  def unique_body
    !Entry.exists?(body: body)
  end

end
