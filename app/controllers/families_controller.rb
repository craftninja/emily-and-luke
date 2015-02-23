class FamiliesController < ApplicationController

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      redirect_to new_family_guest_path(@family)
    else
      render :new
    end
  end

  private

  def family_params
    params.require(:family).permit(:secret_code, :address, :city, :state, :zip)
  end

end
