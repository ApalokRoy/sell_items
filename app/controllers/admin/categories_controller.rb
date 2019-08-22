class Admin::CategoriesController < Admin::HomeController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New Category is Created Sucessfully!"
      redirect_to admin_category_path(@category)
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
      redirect_to admin_category_path(@category)
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:dark] = "Category has been deleted Sucessfully!"
    redirect_to admin_categories_path
  end

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.ordering.paginate(page: params[:categories_page], per_page: 20)
  end

  private
    # Permiseble parameters.
    def category_params
      params.require(:category).permit(:name)
    end
end