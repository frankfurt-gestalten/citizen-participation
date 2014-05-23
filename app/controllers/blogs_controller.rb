class BlogsController < ApplicationController
  load_and_authorize_resource

  def index
    @blogs = Blog.order('created_at DESC').page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.json { render json: @blogs }
      format.atom { render :layout => false }
    end
  end

  def show
    @blog_comments = @blog.comments.arrange(:order => :created_at)

    respond_to do |format|
      format.html
      format.json { render json: @blog }
    end
  end

  def new
  end

  def edit
  end

  def create
    @blog = current_user.blogs.build(params[:blog])

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

end


