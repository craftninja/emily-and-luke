class PhotosController < ApplicationController
  before_action :verify_admin, except: [:index, :show]

  def index
    @photos = Photo.all.order(:date).reverse
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:notice] = 'Photo was successfully added'
      redirect_to photos_path
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      flash[:notice] = 'Photo was successfully updated'
      redirect_to photos_path
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = 'Photo was successfully deleted'
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:img_url, :date, :caption)
  end

end
