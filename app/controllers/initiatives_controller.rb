# encoding: utf-8

class InitiativesController < ApplicationController
  load_and_authorize_resource except: [:index, :feed, :initiativen_short]
  impressionist

  def index
    @quarters = all_quarters

    @map_lat, @map_lng = '50.119182', '8.677139'
    @map_zoom = 11

    if params[:quarter].present?
      @quarter_id = params[:quarter].to_i
      @quarter = @quarters.find { |q| q.id == @quarter_id }
      @map_lat = @quarter.long
      @map_lng = @quarter.lat
      @map_zoom = 14
    end

    #@categories = Category.all

    case params[:filter]
    when nil, ''
      @initiatives = Initiative.order('updated_at DESC')
    else
      @initiatives = Initiative.joins(:categories).where("categories.name = ?", params[:filter])
    end
    if @quarter
      @initiatives = @initiatives.within_quarter(@quarter_id)
    end
    @initiatives_map = @initiatives.where('visible = true')
    @initiatives = @initiatives.page(params[:page]).per(25)

    authorize! :index, Initiative

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
      format.json { render json: @initiatives }
    end
  end

  def initiativen_short
    @initiatives = Initiative.where('last_comment_at >= ? or created_at >= ?', Date.today - 7, Date.today - 7).order('last_comment_at DESC')
    respond_to do |format|
      format.atom { render :layout => false }
    end
  end

  def show
    @comments = @initiative.comments.arrange(:order => :created_at)

    if current_user
      @supporting = current_user.sympathies.exists?(:initiative_id => @initiative.id)
      @subscribed = current_user.subscriptions.exists?(:subscribable_id => @initiative.id, :subscribable_type => 'Initiative')
    end

    respond_to do |format|
      format.html
      format.json { render json: @initiative }
    end
  end

  def new
    @initiative = Initiative.new
    load_quarters

    respond_to do |format|
      format.html
      format.json { render json: @initiative }
    end
  end

  def edit
    load_quarters
  end

  def create
    @initiative = current_user.initiatives.build(params[:initiative])
    @initiative.visible = params[:visible].present? ? params[:visible] : true
    @initiative.subscriptions.build(user: current_user)

    respond_to do |format|
      if @initiative.save
        InitiativenMailer.new_initiative(@initiative).deliver
        notificaiton = {
          Initiative => { new: [@initiative] }
        }
        QuarterSubscription.where('user_id != ?', current_user.id).where(quarter_id: @initiative.quarter_id).each do |subscription|
          SubscriptionMailer.notify(subscription, notificaiton).deliver
        end

        format.html { redirect_to @initiative, notice: 'Die Initiative wurde erfolgreich erstellt.' }
        format.json { render json: @initiative, status: :created, location: @initiative }
      else
        format.html do
          load_quarters
          render action: "new"
        end
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @initiative.update_attributes(params[:initiative])
        notificaiton = {
          Initiative => { updated: [@initiative] }
        }
        QuarterSubscription.where('user_id != ?', current_user.id).where(quarter_id: @initiative.quarter_id).each do |subscription|
          SubscriptionMailer.notify(subscription, notificaiton).deliver
        end
        # Send to subscriber
        format.html { redirect_to @initiative, notice: 'Die Initiative wurde erfolgreich gepeichert.' }
        format.json { head :no_content }
      else
        format.html do
          load_quarters
          load_kommunen
          render action: "edit"
        end
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @initiative.destroy

    respond_to do |format|
      format.html { redirect_to initiatives_url, notice: 'Initiative erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  def supporter_count
    @supporters = Supporter.all(:conditions => ["created_at >= ?", Date.today]).size

    render :json => { :value => @supporters, :timestamp =>  Date.today.to_time.to_i }
  end

  def support
    @initiative = Initiative.find(params[:id])
    unless @initiative.supporters.exists?(user_id: current_user.id)
      @initiative.supporters.create!(user: current_user)
    end

    @initiative.subscribe(current_user)

    @supporting = true
    InitiativenMailer.new_supporter(@initiative, current_user).deliver

    respond_to do |format|
      format.js { render 'update_support' }
    end
  end

  def unsupport
    @initiative = Initiative.find(params[:id])
    if supporter = @initiative.supporters.find_by_user_id(current_user.id)
      supporter.destroy
    end

    @supporting = false

    respond_to do |format|
      format.js { render 'update_support' }
    end
  end

  def subscribe
    @initiative = Initiative.find(params[:id])
    @initiative.subscribe(current_user)

    @subscribed = true

    respond_to do |format|
      format.js { render 'update_subscription' }
    end
  end

  def unsubscribe
    @initiative = Initiative.find(params[:id])
    @initiative.unsubscribe(current_user)

    @subscribed = false

    respond_to do |format|
      format.js { render 'update_subscription' }
    end
  end

  def contact
    @initiative = Initiative.find(params[:id])
    render 'kontakt_form'
  end

  def contact_submit
    @initiative = Initiative.find(params[:id])
    text = params[:message][:body]
    respond_to do |format|
      if text.present?
        InitiativenMailer.initiator_email(current_user, @initiative, text).deliver
        format.html { redirect_to @initiative, notice: 'Die Nachricht wurde verschickt.' }
      else
        flash.now[:alert] = 'Leider keine Nachricht vorhanden.'
        format.html { redirect_to contact_initiative_path, notice: 'Ein Text für eine Nachricht fehlt.' }
      end
    end
  end

  def contact_moderator
    @initiative = Initiative.find(params[:id])
    render 'kontakt_moderator'
  end

  def contact_moderator_submit
    @initiative = Initiative.find(params[:id])
    text = params[:message][:body]
    respond_to do |format|
      if text.present?
        User.moderators.each do |moderator|
          InitiativenMailer.initiator_moderator_email(current_user, moderator, @initiative, text).deliver
        end

        format.html { redirect_to @initiative, notice: 'Die Nachricht wurde verschickt.' }
      else
        flash.now[:alert] = 'Leider keine Nachricht vorhanden.'
        format.html { redirect_to contact_moderator_initiative_path, notice: 'Ein Text für eine Nachricht fehlt.' }
      end
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