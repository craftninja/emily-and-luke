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

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    params.each do |key, value|
      guest = User.find_by(:id => key)
      if guest
        guest.update(:attending => value)
      end
    end
    attending = user.family_members.where(:attending => true).count
    flash[:notice] = "You have submitted an RSVP for #{attending}"
    redirect_to rsvp_path(user)
  end

end
