class Admin::CategoriesController < ApplicationController
  before_action :authenticate

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New Category is Created Sucessfully!"
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category Information is updated Sucessfully!"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category has been deleted Sucessfully!"
    redirect_to root_url
  end

  private
    # Permiseble parameters.
    def category_params
      params.require(:category).permit(:name)
    end
    
    # Before filters
    # Authenticates current user is admin or not.
    def authenticate
      if logged_in_user
        redirect_to root_url unless current_user.admin?
      end
    end
end
