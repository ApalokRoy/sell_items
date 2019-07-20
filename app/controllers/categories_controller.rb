class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.paginate(page: params[:categories_page], per_page: 20)
  end
end
