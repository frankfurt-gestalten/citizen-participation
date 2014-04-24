class BannersController < ApplicationController
  load_and_authorize_resource

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(params[:banner])

    if @banner.save
      redirect_to banners_path, notice: "Foto wurde erfolgreich hochgeladen."
    else
      render 'new'
    end
  end

  def index
    @banners = Banner.all
  end

  def show
    @content = @banner
    @comments = @banner.comments.arrange(order: :created_at)
    load_recent_items
  end

  def load_recent_items
    @recent_ideas = Idea.recent
    @recent_comments = Comment.recent
  end

  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      flash[:alert] = "This data set was removed."
      format.html { redirect_to banners_url }
      format.json { head :no_content }
    end
  end

  def update
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.update_attributes(params[:Banner])
        format.html { redirect_to(@banner, :notice => t('activerecord.successful.messages.updated', :model => @banner.class.model_name.human)) }
        format.json { render json: "OK", status: 200}
      else
        format.html { render action: "edit" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def sidebar
    false
  end
end