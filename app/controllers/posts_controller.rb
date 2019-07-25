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
  end

  def destroy
    logged_in_user
    redirect_to root_url unless current_user?(@user) || current_user.admin?
    session[:return_to] = request.referer
    Post.find(params[:id]).destroy
    flash[:success] = "Advertisement has been deleted Sucessfully!"
    redirect_to session[:return_to]
  end

  def sendmail
    logged_in_user

    if @post.user_id != current_user.id
      PostMailer.send_email(@post, current_user).deliver_later
      redirect_to user_post_path(@user, @post)
    end
  end

  def search
    if params[:search_posts].presence
      name = params[:search_posts][:name].presence && params[:search_posts][:name]
      city = params[:search_posts][:city].presence && params[:search_posts][:city]
      if name.present? && city.present?
        @intermediatePosts = Post.search_approved(city)
        @posts = @intermediatePosts.search_approved(city)
      elsif city.present?
        @posts = Post.search_approved(city)
      else
        @posts = Post.search_approved(name)
      end
      binding.pry
      
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
