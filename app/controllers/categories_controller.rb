class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.approved.paginate(page: params[:posts_page], per_page: 20)
  end

  def index
    @categories = Category.ordering.paginate(page: params[:categories_page], per_page: 20)
  end
end
