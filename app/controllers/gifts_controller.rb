class GiftsController < ApplicationController
  before_action :verify_admin

  def index
    @gift = Gift.new
    @gifts = Gift.all.order(:family_id)
  end

  def create
    @gift = Gift.new(gift_params)
    if @gift.save
      redirect_to gifts_path
    else
      render :index
    end
  end

  def update
    @gift = Gift.find(params[:id])
    @gift.thank_you_sent = true
    @gift.save
    redirect_to gifts_path
  end

  def gift_params
    params.require(:gift).permit(:family_id, :description)
  end

end
