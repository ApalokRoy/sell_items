class Admin::ReviewsController < ApplicationController
  before_action :authenticate

  # Lists all the posts that are yet to be approved
  def pending
    @reviews = Review.includes(:post).yet_to_be_approved
  end

  # Approve the pending post
  def status
    @review = Review.find(params[:id])
    @review.update_attribute(:approved_id, current_user.id)
    flash[:success] = "Review is approved!"
    redirect_to pending_admin_reviews_path
  end

  def show
    @review = Review.find(params[:id])
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