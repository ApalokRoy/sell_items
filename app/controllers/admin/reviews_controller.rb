class Admin::ReviewsController < Admin::HomeController
  # Lists all the posts that are yet to be approved
  def pending
    @reviews = Review.includes(:post).yet_to_be_approved
  end

  # Approve the pending post
  def status
    @review = Review.find(params[:id])
    @review.update_attribute(:approved_id, current_user.id)
    flash[:info] = "Review is approved!"
    redirect_to admin_home_path
  end

  def show
    @review = Review.find(params[:id])
  end

  def index
    @reviews = Review.includes(:user, :post).all
  end
end