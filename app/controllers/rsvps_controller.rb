class RsvpsController < ApplicationController
  before_action :validate_guest, :except => [:index, :find_guest]
  skip_before_action :rsvp_session_end, :except => [:index, :find_guest]
  helper_method :current_guest

  def current_guest
    @current_guest ||= Guest.find_by(:id => session[:current_guest])
  end

  def index
  end

  def find_guest
    session[:fail_names] ||= []
    guests_with_last_name = Guest.where(:last_name => params[:last_name])
    guest = guests_with_last_name.find_by(:first_name => params[:first_name])
    if guest && guest.family.secret_code = params[:secret_code]
      session[:fail_names] = nil
      session[:current_guest] = guest.id
      redirect_to rsvp_path(guest.id)
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
    @guest = Guest.find(params[:id])
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    guest = Guest.find(params[:id])
    guest.family.address = params[:address]
    guest.family.city = params[:city]
    guest.family.state = params[:state]
    guest.family.zip = params[:zip]
    guest.family.save
    params.each do |key, value|
      guest_found = Guest.find_by(:id => key)
      if guest_found
        guest_found.update(:attending => value)
      end
    end
    attending = guest.family_members.where(:attending => true).count
    flash[:notice] = "You have submitted an RSVP for #{attending}"
    redirect_to rsvp_path(guest)
  end

  def edit_dietary_restrictions
    @guest = Guest.find(params[:id])
  end

  def update_dietary_restrictions
    guest = Guest.find(params[:id])
    guest.update(:dietary_restrictions => params[:dietary_restrictions])
    flash[:notice] = "You have updated dietary restrictions for #{guest.full_name}"
    redirect_to rsvp_path(guest)
  end

  private

  def validate_guest
    if !current_guest
      redirect_to rsvps_path
    end
  end

end
