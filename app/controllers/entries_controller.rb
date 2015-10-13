class EntriesController < ApplicationController

  def index
    if params[:query].present?
      @entries = Entry.query params[:query], page: params[:page], skip_filter: params[:skip_filter]
    else
      @entries = Entry.page(params[:page])
      @entries = @entries.processed unless params[:skip_filter]
    end
    return render partial: 'partials/entries_list' if request.xhr?
  end


  def show
    @entry = Entry.find_by! id: params[:id]
  end

end
