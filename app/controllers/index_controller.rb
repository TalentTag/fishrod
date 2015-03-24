class IndexController < ApplicationController

  def entries
    @entries = params[:source].present? ? Entry.by_source(params[:source]) : Entry.all
  end

end
