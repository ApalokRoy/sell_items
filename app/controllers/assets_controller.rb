class AssetsController < ApplicationController
  before_action :authenticate
  before_action :find_user_and_post

  def destroy
    Asset.find(params[:id]).destroy
    redirect_to user_post_path(@user, @post)
  end

  private
  def authenticate
    if logged_in_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless current_user?(@user)
    end
  end

  # Find User and Post
  def find_user_and_post
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end
end