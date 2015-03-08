class GuestsController < ApplicationController
  before_action :verify_admin

  def index
    # Order by guest.family.id
    @guests = Guest.all.sort_by { |guest| guest.family.id}

    # Order by last name
    # @guests = Guest.all.order(:last_name)
  end

  def new
    @family = Family.find(params[:family_id])
    @guest = Guest.new
  end

  def create
    @guest = Guest.new
    @family = Family.find(params[:family_id])
    if @guest.update(guest_params)
      FamilyMembership.create!(:guest_id => @guest.id, :family_id => @family.id)
      redirect_to new_family_guest_path(@family)
    else
      render :new
    end
  end

  def destroy
    guest = Guest.find(params[:id])
    guest.destroy
    family = Family.find(params[:family_id])
    if family.guests.any?
      redirect_to new_family_guest_path(family)
    else
      family.destroy
      redirect_to guests_path
    end
  end

  def invite_update
    family = Guest.find(params[:id]).family
    family.update(:invitation => params[:family][:invitation])
    redirect_to guests_path
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name)
  end

end
