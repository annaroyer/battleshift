class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:notice] = "Incorrect credentials"
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
