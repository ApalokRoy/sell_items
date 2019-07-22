class PostsController < ApplicationController
  before_action :authenticate, except: [:show]
  before_action :find_user
  before_action :find_post, only: [:edit, :update, :show, :destroy]

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:success] = "#{@post.name} is Created Successfully!"
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "#{@post.name} is Updated Successfully!"
      redirect_to user_post_path(@user, @post)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Advertisement has been deleted Sucessfully!"
    redirect_to user_path(@user)
  end

  
  private
    # Permiseble parameters.
    def post_params
      params.require(:post).permit(:name, :category_id, :description,
                                    :user_id, :phone_number, :city)
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