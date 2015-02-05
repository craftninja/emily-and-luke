class RsvpsController < ApplicationController

  def index
  end

  def find_user
    session[:fail_names] ||= []
    users_with_last_name = User.where(:last_name => params[:last_name])
    user = users_with_last_name.find_by(:first_name => params[:first_name])
    if user && user.family.secret_code = params[:secret_code]
      session[:fail_names] = nil
      redirect_to rsvp_path(user.id)
    else
      session[:fail_names] << "#{params[:first_name]} #{params[:last_name]}"
      if session[:fail_names].count < 3
        flash[:error] = 'Oh no! We could not find your record. Try again.'
        redirect_to rsvps_path
      else
        session[:fail_names] = nil
        flash[:error] = 'Still could not find you. Contact us and we can sort it out!'
        redirect_to root_path
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.family.address = params[:address]
    user.family.city = params[:city]
    user.family.state = params[:state]
    user.family.zip = params[:zip]
    user.family.save
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

  def edit_dietary_restrictions
    @user = User.find(params[:id])
  end

  def update_dietary_restrictions
    user = User.find(params[:id])
    user.update(:dietary_restrictions => params[:dietary_restrictions])
    flash[:notice] = "You have updated dietary restrictions for #{user.full_name}"
    redirect_to rsvp_path(user)
  end

end
