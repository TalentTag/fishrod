class Entry < ActiveRecord::Base

  scope :by_source, ->(source){ where(source: source) }

end
