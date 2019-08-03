class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:category).paginate(page: params[:posts_page], per_page: 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Congratulation, your information is saved Sucessfully!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your information is updated Sucessfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    # Permiseble parameters.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # Before filters
    # Authenticates correct user.
    def authenticate
      if logged_in_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
      end
    end
end