class SessionsController < ApplicationController
  before_action :set_auth

  def new
    session[:return_to] = request.referer    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_url
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def sociallogin
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.expect('extra')
    user = User.sign_in_using_omniauth(auth)
    log_in user
    redirect_back_or root_url
  end

  def destroy
    session[:return_to] = request.referer
    log_out
    redirect_to session[:return_to]
  end

  private
      # Initialize @auth.
      def set_auth
        @auth = session[:omniauth] if session[:omniauth]
      end
end
