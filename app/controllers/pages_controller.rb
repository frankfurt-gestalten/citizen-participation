class PagesController < ApplicationController
  load_and_authorize_resource :except => [:start]

  def start
    authorize! :show, Page
    @random_initiative = Initiative.where('updated_at >= ?', Date.today - 600).order("random()")
    @initiatives = Initiative.where("lat != '' and visible = true").order(:created_at).limit(50)
    @quarters = all_quarters
    @quarters_id_to_location = @quarters.each_with_object({}) do |quarter, hash|
      hash[quarter.id] = { coords: [quarter.lat, quarter.long] }
    end

    @antraeges = Antraege.where("lat != ''").select([:id, :title, :lat, :long, :datum]).order('datum DESC').limit(100)

    @constructions = Construction.where("lat != ''").current.order(:updated_at).limit(100)

    # Select Stadtteil
    @selected_quarter = nil
    @streets = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @initiatives }
    end
  end

  def einfuehrung

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end

  def show
    if params[:id]
      @page = Page.find(params[:id])
    else
      @page = Page.find_by_slug!(params[:slug])
    end

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end

  def edit
  end

  def create

    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def contact_form
    render 'kontakt_form'
  end

  def contact_submit
    text = params[:message][:body]

    if current_user
      username = current_user.username
      email = current_user.email
    else
      username = params[:message][:opfname]
      email = params[:message][:email]
    end

    respond_to do |format|
      if text.present?
        KontaktMailer.kontakt_form(text, username, email).deliver
        format.html { redirect_to root_path, notice: 'Die Nachricht wurde verschickt.' }
      else
        flash.now[:alert] = 'Leider keine Nachricht vorhanden.'
        format.html { redirect_to contact_form_path, notice: 'Ein Text für eine Nachricht fehlt.' }
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def fill_in_blanks(date_hash, first_day, last_day)
    (first_day..last_day).each do |current_day|
      date_hash[current_day.strftime('%Y-%m-%d')] ||= 0
    end
  end
  def load_recent_items
    @recent_ideas = Initiativen.recent
    @recent_comments = Comment.recent
  end
  private

end


