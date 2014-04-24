class WidgetsController < ApplicationController
  load_and_authorize_resource

  def index
    @widgets = Widget.order(:created_at).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @widgets }
    end
  end

  def new
    @widget = Widget.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @widget }
    end
  end

  def edit
    @widget = Widget.find(params[:id])
  end

  def create
    @banner = Banner.new(params[:banner])

    respond_to do |format|
      if @widget.save
        format.html { redirect_to widgets_url, notice: 'Widget wurde erfolgreich gespeichert.' }
        format.json { render json: @widget, status: :created, location: @widget }
      else
        format.html { render action: "new" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @widget = Widget.find(params[:id])

    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        format.html { redirect_to widgets_url, notice: 'Widget wurde erfolgreich gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy

    respond_to do |format|
      format.html { redirect_to widgets_url }
      format.json { head :no_content }
    end
  end
end
