class PostsController < ApplicationController
  before_action :authenticate, except: [:show, :sendmail, :destroy, :search]
  before_action :find_user, except: :search
  before_action :find_post, only: [:edit, :update, :show, :destroy, :sendmail, :myshow]

  def new
    @post = @user.posts.new
    @asset = @post.assets.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      if params[:post][:asset].present? 
        params[:post][:asset]['image'].each do |img|
          @photo = @post.assets.create!(image: img)
        end
      end

      flash[:success] = "#{@post.name} is Created Successfully!"
      redirect_to my_show_user_post_path(@user, @post)
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
          @photo = @post.assets.create!(image: img)
        end
      end

      flash[:success] = "#{@post.name} is Updated Successfully!"
      redirect_to my_show_user_post_path(@user, @post)
    else
      render 'edit'
    end
  end

  def show
    @assets = @post.assets
    @review = params[:review].present? ? Review.find(params[:review]) : @post.reviews.new
    @reviews = @post.reviews.includes(:user).approved.paginate(page: params[:reviews_page], per_page: 20)
    @pendingreviews = @post.reviews.includes(:user).pending_to_be_approved(current_user.id) if logged_in?
  end

  def destroy
    if logged_in_user
      redirect_to root_url unless current_user?(@user) || current_user.admin?     
      Post.find(params[:id]).destroy
      flash[:dark] = "Advertisement has been deleted Sucessfully!"
      
      if request.referer.include?("admin")
        redirect_to admin_home_path
      else
        redirect_to my_index_user_posts_path
      end
    end
  end

  def sendmail
    if logged_in_user
      if @post.user == current_user
        flash[:warning] = "You can't show interest on your own advertisement!"
      else
        PostMailer.send_email(@post, current_user).deliver_later
        flash[:primary] = "Your responce is saved successfully!"
      end  
      redirect_to user_post_path(@user, @post)
    end
  end

  def search
    if params[:search_posts].presence
      @posts = Post.search_approved(params[:search_posts])
      if @posts.empty?
        redirect_to root_url
        flash[:warning] = "Sorry, no advertisements matches your request."
      end
    end
  end

  def myindex
     @posts = @user.posts.includes(:category)
  end

  def myshow
    @assets = @post.assets
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