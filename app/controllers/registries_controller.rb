class RegistriesController < ApplicationController
  before_action :verify_admin, except: [:index]

  def index
    @registries = Registry.all
  end

  def new
    @registry = Registry.new
  end

  def create
    @registry = Registry.new(registry_params)
    if @registry.save
      flash[:notice] = 'Registry was successfully created'
      redirect_to registries_path
    else
      render :new
    end
  end

  def edit
    @registry = Registry.find(params[:id])
  end

  def update
    @registry = Registry.find(params[:id])
    if @registry.update(registry_params)
      flash[:notice] = 'Registry was successfully updated'
      redirect_to registries_path
    else
      render :edit
    end
  end

  def destroy
    @registry = Registry.find(params[:id])
    @registry.destroy
    flash[:notice] = 'Registry was successfully deleted'
    redirect_to registries_path
  end

  private

  def registry_params
    params.require(:registry).permit(:img_url, :title, :url, :description)
  end

end
