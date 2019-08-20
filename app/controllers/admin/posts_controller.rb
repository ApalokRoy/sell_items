class Admin::PostsController < Admin::HomeController
  # Lists all the posts that are yet to be approved
  def pending
    @posts = Post.includes(:user).yet_to_be_approved
  end

  # Approve the pending post
  def status
    @post = Post.find(params[:id])
    @post.update_attribute(:approved_id, current_user.id)
    flash[:success] = "Advertisement is approved!"
    redirect_to pending_admin_posts_path
  end

  def show
    @post = Post.find(params[:id])
    @assets = @post.assets
  end
end