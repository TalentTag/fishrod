class EntriesController < ApplicationController

  def index
    if params[:query]
      options = { excerpts: { around: 250 }, order: 'created_at DESC', per_page: 100 }
      options[:with] = { source_id: SourceMap.all[params[:source].to_sym] } if params[:source].present?

      @entries = Entry.search params[:query], options
      @entries.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
    end
    return render partial: 'partials/entries_list' if request.xhr?
  end


  def show
    @entry = Entry.find_by! id: params[:id]
  end

end
