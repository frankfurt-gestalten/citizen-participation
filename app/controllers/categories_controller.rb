class CategoriesController < ApplicationController
  load_and_authorize_resource

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to category_path(@category), notice: "Category has been successfully created"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to category_path(@category), notice: "Category has been successfully updated"
    else
      render 'update'
    end
  end

  def show
  end
end
