class EntriesController < ApplicationController

  def index
    query = params[:query] || (params[:search].present? && begin
      search = Search.find(params[:search])
      params[:query] = search.try(:pattern)
    end)

    if query.present?
      @entries = Entry.query query, page: params[:page], skip_filter: params[:skip_filter], date: params[:date]
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

  def reject
    Entry.find_by!(id: params[:id]).update state: State::REJECTED
    render nothing: true, status: :no_content
  end

end
