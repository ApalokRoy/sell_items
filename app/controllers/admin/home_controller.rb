class Admin::HomeController < ApplicationController
  before_action :authenticate

  def index
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