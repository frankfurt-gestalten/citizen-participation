class NeuigkeitenController < ApplicationController
  load_and_authorize_resource

  def index
    @neuigkeiten = Neuigkeiten.all
    @neuigkeiten_with_datum = Neuigkeiten.where("datum is not Null")
    @neuigkeiten_by_date = @neuigkeiten_with_datum.group_by {|i| i.datum.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @neuigkeiten }
    end
  end

  def show
    @neuigkeiten = Neuigkeiten.find(params[:id])
    @comments_recent = Comment.recent

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @neuigkeiten }
    end
  end

  def new
    @neuigkeiten = Neuigkeiten.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @neuigkeiten }
    end
  end

  def edit
    @neuigkeiten = Neuigkeiten.find(params[:id])
  end

  def create
    @neuigkeiten = current_user.neuigkeiten.build(params[:neuigkeiten])

    respond_to do |format|
      if @neuigkeiten.save
        format.html { redirect_to @neuigkeiten, notice: 'Die Veranstaltung wurde erfolgreich gespeichert.' }
        format.json { render json: @neuigkeiten, status: :created, location: @neuigkeiten }
      else
        format.html { render action: "new" }
        format.json { render json: @neuigkeiten.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @neuigkeiten = Neuigkeiten.find(params[:id])

    respond_to do |format|
      if @neuigkeiten.update_attributes(params[:neuigkeiten])
        format.html { redirect_to @neuigkeiten, notice: 'Die Veranstaltung wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @neuigkeiten.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @neuigkeiten = Neuigkeiten.find(params[:id])
    @neuigkeiten.destroy

    respond_to do |format|
      format.html { redirect_to neuigkeitens_path, notice: 'Die Veranstaltung wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
end
