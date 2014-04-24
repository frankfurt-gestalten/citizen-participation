class ConstructionsController < ApplicationController
  load_and_authorize_resource

  def index
    @constructions = Construction.current.order('start_date DESC')
    respond_to do |format|
      format.html
      format.json { render json: @construction }
      format.atom { render :layout => false }
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def show
    @comments = @construction.comments.arrange(:order => :created_at)
    @construction = Construction.find(params[:id])
    @comments_recent = Comment.recent

    respond_to do |format|
      format.html
      format.json { render json: @construction }
    end
  end

  def new
    @construction = Construction.new

    respond_to do |format|
      format.html
      format.json { render json: @construction }
    end
  end

  def edit
    @construction = Construction.find(params[:id])
  end

  def create
    @construction = current_user.construction.build(params[:construction])

    respond_to do |format|
      if @construction.save
        format.html { redirect_to @construction, notice: 'Die Baustelle wurde erfolgreich gespeichert.' }
        format.json { render json: @construction, status: :created, location: @construction }
      else
        format.html { render action: "new" }
        format.json { render json: @construction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @construction = Construction.find(params[:id])

    respond_to do |format|
      if @construction.update_attributes(params[:construction])
        format.html { redirect_to @construction, notice: 'Die Veranstaltung wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @construction = Construction.find(params[:id])
    @construction.destroy

    respond_to do |format|
      format.html { redirect_to constructions_path, notice: 'Die Veranstaltung wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
end
