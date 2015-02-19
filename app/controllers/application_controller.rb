class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :rsvp_session_end
  helper_method :current_user

  def rsvp_session_end
    session[:current_guest] = nil
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:current_user])
  end

end
