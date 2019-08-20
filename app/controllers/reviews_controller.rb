class ReviewsController < ApplicationController
  before_action :find_user_and_post
  before_action :logged_in_user

  def edit
    @review = Review.find(params[:id])
    redirect_to user_post_path(@user, @post, review: @review.id)
  end

  def create
    @review = @post.reviews.new(review_params)
    if @post.approved_id.present? && @review.save
      flash[:success] = "Review is uploaded for approval!"
      respond_to do |format|
        format.js { render file: "posts/create_success.js.erb" }
      end
    else
      respond_to do |format|
        format.js { render file: "posts/create_failure.js.erb" }
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params) && @post.approved_id.present?
      @review.update_attribute(:approved_id, nil)
      flash[:success] = "Review is updated for approval!"
      respond_to do |format|

        format.js { redirect_to user_post_path(@user, @post) }
      end
    else
      respond_to do |format|
        format.js { render file: "posts/create_failure.js.erb" }
      end
    end
  end


  def destroy
    redirect_to root_url unless current_user.admin?
    Review.find(params[:id]).destroy
    flash[:success] = "Review has been deleted Sucessfully!"
    redirect_to admin_home_path
  end


  private
    # Permiseble parameters.
    def review_params
      params.require(:review).permit(:post_id, :user_id, :rating, :content, :heading)
    end

    # Before filters
    # Find User and Post
    def find_user_and_post
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
    end
end