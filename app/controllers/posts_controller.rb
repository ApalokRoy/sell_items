class PostsController < ApplicationController
  before_action :authenticate, except: [:show, :sendmail, :destroy, :search]
  before_action :find_user, except: :search
  before_action :find_post, only: [:edit, :update, :show, :destroy, :sendmail]

  def new
    @post = @user.posts.new
    @asset = @post.assets.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      if params[:post][:asset].present? 
        params[:post][:asset]['image'].each do |img|
          @photo = @post.assets.create!(:image => img)
        end
      end

      flash[:success] = "#{@post.name} is Created Successfully!"
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def edit
    @post.assets.build unless @post.assets.any?
  end

  def update
    if @post.update_attributes(post_params)
      if params[:post][:asset].present? 
        params[:post][:asset]['image'].each do |img|
          @photo = @post.assets.create!(:image => img)
        end
      end

      flash[:success] = "#{@post.name} is Updated Successfully!"
      redirect_to user_post_path(@user, @post)
    else
      render 'edit'
    end
  end

  def show
    @assets = @post.assets
    @review = @post.reviews.new
    @reviews = @post.reviews.includes(:user).approved.paginate(page: params[:reviews_page], per_page: 20)
  end

  def destroy
    if logged_in_user
      redirect_to root_url unless current_user?(@user) || current_user.admin?
      session[:return_to] = request.referer
      Post.find(params[:id]).destroy
      flash[:success] = "Advertisement has been deleted Sucessfully!"
      redirect_to session[:return_to]
    end
  end

  def sendmail
    if logged_in_user
      PostMailer.send_email(@post, current_user).deliver_later
      redirect_to user_post_path(@user, @post)
    end
  end

  def search
    if params[:search_posts].presence
      @posts = Post.search_approved(params[:search_posts])
    end
  end

  private
    # Permiseble parameters.
    def post_params
      params.require(:post).permit(:name, :category_id, :description,
                                  :user_id, :phone_number, :city, asset_attributes: [:image])
    end
  
    # Before filters
    # Authenticates correct user.
    def authenticate
      if logged_in_user
        redirect_to root_url unless current_user?(find_user)
      end
    end

    # Find User
    def find_user
      @user = User.find(params[:user_id])
    end

    # Find Posts
    def find_post
      @post = @user.posts.find(params[:id])
    end
end
