class Admin::PostsController < ApplicationController
  before_action :authenticate

  # Lists all the posts that are yet to be approved
  def pending
    @posts = Post.yet_to_be_approved
  end

  # Approve the pending post
  def status
    @post = Post.find(params[:id])
    @post.update_attribute(:approved_id, current_user.id)
    redirect_to action: 'pending'
  end

  private   
    # Before filters
    # Authenticates current user is admin or not.
    def authenticate
      if logged_in_user
        redirect_to root_url unless current_user.admin?
      end
    end
end