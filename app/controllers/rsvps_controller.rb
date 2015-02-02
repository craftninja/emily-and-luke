class RsvpsController < ApplicationController

  def index
  end

  def find_user
    users_with_last_name = User.where(:last_name => params[:last_name])
    user = users_with_last_name.find_by(:first_name => params[:first_name])
    redirect_to rsvp_path(user.id)
  end

  def show
    @user = User.find(params[:id])
  end

end
