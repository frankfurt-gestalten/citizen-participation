class SearchController < ApplicationController
  def index
    @results = Antraege.search(params[:q]).page(params[:page]).per(25)
    #@count = @results.count()
  end
end