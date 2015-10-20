class EntriesController < ApplicationController

  def index
    if params[:query].present?
      @entries = Entry.query params[:query], page: params[:page], skip_filter: params[:skip_filter], date: params[:date]
    else
      @entries = Entry.page(params[:page])
      @entries = @entries.processed unless params[:skip_filter]
      if params[:date].present?
        date = Date.parse params[:date]
        @entries = @entries.where('fetched_at > ? AND fetched_at < ?', date.beginning_of_day, date.end_of_day)
      end
    end
    return render partial: 'partials/entries_list' if request.xhr?
  end


  def show
    @entry = Entry.find_by! id: params[:id]
  end

end
