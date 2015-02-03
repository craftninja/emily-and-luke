class RsvpsController < ApplicationController

  def index
  end

  def find_user
    session[:fail_names] ||= []
    users_with_last_name = User.where(:last_name => params[:last_name])
    user = users_with_last_name.find_by(:first_name => params[:first_name])
    if user
      session[:fail_names] = nil
      redirect_to rsvp_path(user.id)
    else
      session[:fail_names] << "#{params[:first_name]} #{params[:last_name]}"
      if session[:fail_names].count < 3
        flash[:error] = 'Oh no! We could not find your record. Try again.'
        redirect_to rsvps_path
      else
        AdminMailer.fail_find_invitee(session[:fail_names]).deliver_now
        session[:fail_names] = nil
        flash[:error] = 'Still could not find you. An email was sent to Emily and Luke, we will be in touch!'
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
