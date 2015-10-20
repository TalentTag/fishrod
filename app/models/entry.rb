class Entry < ActiveRecord::Base

  scope :by_source, ->(source){ where(source: source) }
  scope :processed, -> { where state: State::PROCESSED }
  default_scope ->{ order(created_at: :desc) }

  validate :unique_body, on: :create

  ENTRIES_PER_PAGE = 20
  paginates_per ENTRIES_PER_PAGE


  def self.query query, params={}
    page = params[:page].presence.try(:to_i) || 1

    options = { with: {}, excerpts: { around: 250 }, order: 'fetched_at DESC', per_page: ENTRIES_PER_PAGE }
    options[:with][:state] = State::PROCESSED unless params[:skip_filter]
    if params[:date].present?
      date = Date.parse params[:date]
      options[:with][:fetched_at] = date.beginning_of_day..date.end_of_day
    end

    entries = Entry.search query, options
    entries.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
    entries.page(page)
  end


  protected

  def unique_body
    errors[:body] << "Body is non-unique" if Entry.exists?(body: body)
  end

end
