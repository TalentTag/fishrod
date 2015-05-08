class Entry < ActiveRecord::Base

  scope :by_source, ->(source){ where(source: source) }
  default_scope ->{ order(created_at: :desc) }

  validate :unique_body


  protected

  def unique_body
    errors[:body] << "Body is non-unique" if Entry.exists?(body: body)
  end

end
