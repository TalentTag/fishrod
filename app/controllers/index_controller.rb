class IndexController < ApplicationController

  ENTRIES_LIMIT = 30

  def entries
    @entries = params[:source].present? ? Entry.by_source(params[:source]).limit(ENTRIES_LIMIT) : Entry.limit(ENTRIES_LIMIT)
  end

end
