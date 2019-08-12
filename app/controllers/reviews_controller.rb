class ReviewsController < ApplicationController
  before_action :find_user
  before_action :find_post

  def create
    if logged_in_user
      @review = @post.reviews.new(review_params)
      if @post.approved_id.present? && @review.save
        # redirect_to user_post_path(@user, @post)
        # flash[:success] = "Review is uploaded for approval!"
        respond_to do |format|
          format.js { render file: "posts/create_success.js.erb" }
        end
      else
        respond_to do |format|
          format.js { render file: "posts/create_failure.js.erb" }
        end
      end
    end
  end

  def destroy
    if logged_in_user
      redirect_to root_url unless current_user.admin?
      session[:return_to] = request.referer
      Review.find(params[:id]).destroy
      flash[:success] = "Review has been deleted Sucessfully!"
      redirect_to session[:return_to]
    end
  end


  private
    # Permiseble parameters.
    def review_params
      params.require(:review).permit(:post_id, :user_id, :rating, :content, :heading)
    end

    # Before filters
    # Find User
    def find_user
      @user = User.find(params[:user_id])
    end

    # Find Posts
    def find_post
      @post = @user.posts.find(params[:post_id])
    end  
end