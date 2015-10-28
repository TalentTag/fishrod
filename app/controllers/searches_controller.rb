class SearchesController < ApplicationController

  def index
    @searches = Search.order(:id)
  end

  def create
    Search.create search_params
    redirect_to :back
  end

  def update
    Search.update params[:id], search_params
    redirect_to :back
  end

  def destroy
    Search.destroy params[:id]
    redirect_to :back
  end


  private

  def search_params
    params.require(:search).permit(:name, :query, :context, :stopwords, :active)
  end

end
