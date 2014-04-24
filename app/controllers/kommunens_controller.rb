class KommunensController < ApplicationController
  def show
    @kommune = Kommune.find(params[:id])
    @quarters = @kommune.quarters
    @initiatives = Initiative.within_kommune(@kommune.id).where('visible = true')
    @antraeges = Antraege.within_kommune(@kommune.id)

    @comments = Comment.for_items(@initiatives.pluck(:id), @antraeges.pluck(:id)).recent

    render layout: 'quarter'
  end

  def quartiere
    kommune = Kommune.find(params[:id])
    render json: kommune.quarters
  end
end