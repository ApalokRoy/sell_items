class PostMailer < ApplicationMailer
  def send_email(post, sender)
    @post = post
    @user = @post.user
    @sender = sender
    @url  = "http://localhost:3000/"
    mail(to: @user.email, subject: 'Advertisement Response')
  end
end
