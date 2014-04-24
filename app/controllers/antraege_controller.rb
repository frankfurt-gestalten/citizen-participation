class AntraegeController < ApplicationController
  load_and_authorize_resource

  def index
    @antraeges = Antraege.order('datum desc').page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.atom { render :layout => false }
      format.json { render json: @antraeges }
    end
  end

  def show
    @comments = @antraege.comments.arrange(:order => :created_at)
    @questions = Question.order('created_at desc').limit(3)

    respond_to do |format|
      format.html
      format.json { render json: @antraege }
    end
  end

  def new
    @antraege = Antraege.new
    load_quarters

    respond_to do |format|
      format.html
      format.json { render json: @antraege }
    end
  end

  def edit
    load_quarters
  end

  def create
    @antraege = Antraege.new(params[:antraege])

    respond_to do |format|
      if @antraege.save
        format.html { redirect_to @antraege, notice: 'Vorlage wurde erfolgreich gespeichert.' }
        format.json { render json: @antraege, status: :created, location: @antraege }
      else
        format.html { render action: "new" }
        format.json { render json: @antraege.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @antraege.update_attributes(params[:antraege])
        format.html { redirect_to @antraege, notice: 'Vorlage wurde erfolgreich aktualisiert.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @antraege.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @antraege.destroy

    respond_to do |format|
      format.html { redirect_to antraeges_url }
      format.json { head :no_content }
    end
  end

  def load_quarters
    @quarters = Quarter.all
    quarters = Quarter.all.sort_by(&:name)
    @quarters_id_to_location = quarters.each_with_object({}) do |quarter, hash|
      hash[quarter.id] = [quarter.lat, quarter.long]
    end
  end
end
