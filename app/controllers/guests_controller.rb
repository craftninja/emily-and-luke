class GuestsController < ApplicationController

  def index
    @guests = Guest.all
  end

  def new
    @family = Family.find(params[:family_id])
    @guest = Guest.new
  end

  def create
    @guest = Guest.new
    if @guest.update(guest_params)
      family = Family.find(params[:family_id])
      FamilyMembership.create!(:guest_id => @guest.id, :family_id => family.id)
      redirect_to new_family_guest_path(family)
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

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name)
  end

end
