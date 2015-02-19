class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user] = user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Could not log you in. Contact us and we can sort it out!'
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

end
