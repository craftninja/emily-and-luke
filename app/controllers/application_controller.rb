class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :rsvp_session_end
  helper_method :current_user, :verify_admin

  def rsvp_session_end
    session[:current_guest] = nil
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:current_user])
  end

  def verify_admin
    if !current_user
      flash[:error] = 'Oops! That does not exist'
      redirect_to root_path
    end
  end

end
