class SearchesController < ApplicationController

  def index
    @searches = Search.all
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
    params.require(:search).permit(:name, :query, :context, :stopwords)
  end

end
