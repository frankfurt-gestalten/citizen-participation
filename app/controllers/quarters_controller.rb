class QuartersController < ApplicationController
  def show
    @quarter_id = params[:id]
    @quarter = Quarter.find(params[:id])
    @initiatives = Initiative.with_location.within_quarter(params[:id]).where('visible = true')
    @streets = @quarter.streets
    @quarters = Quarter.all
    @ob_nummer = Quarter.find(params[:id])
    @antraeges_recent = Antraege.where('ob_nummer = ?', @ob_nummer.ob).order('datum DESC').limit(5)
    @antraeges = Antraege.with_location.within_quarter(params[:id]).select([:id, :title, :lat, :long, :datum]).order('datum DESC').limit(100)
    @comments = Comment.for_items(@initiatives.pluck(:id), @antraeges.pluck(:id))
    @constructions = Construction.with_location.within_quarter(params[:id]).current.order('start_date DESC').limit(100)
  end

  def vorlagen
    @quarter_id = params[:id]
    @ob_nummer = Quarter.find(params[:id])
    @antraeges = Antraege.where('ob_nummer = ?', @ob_nummer.ob).order('datum DESC').page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.json { render json: @antraeges }
    end
  end

  def initiatives
    initiatives = Initiative.within_quarter(params[:id])
    render json: initiatives
  end

  def streets
    # TODO: Sanitize the params[:name] for malicious SQL
    render json: Quarter.new(nil, params[:id]).streets
  end

  def subscribe
    @quarter_id = params[:id]
    unless current_user.quarter_subscriptions.exists?(quarter_id: params[:id])
      current_user.quarter_subscriptions.create!(quarter_id: params[:id])
    end

    @subscribed = true

    respond_to do |format|
      format.js { render 'update_subscription' }
    end
  end

  def unsubscribe
    @quarter_id = params[:id]
    if subscription = current_user.quarter_subscriptions.where(quarter_id: params[:id]).first
      subscription.destroy
    end

    @subscribed = false

    respond_to do |format|
      format.js { render 'update_subscription' }
    end
  end
end
