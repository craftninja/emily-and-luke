class GiftsController < ApplicationController

  def index
    @gift = Gift.new
    @gifts = Gift.all
  end

  def create
    @gift = Gift.new(gift_params)
    if @gift.save
      redirect_to gifts_path
    else
      render :index
    end
  end

  def gift_params
    params.require(:gift).permit(:family_id, :description)
  end

end
