class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      RegistrationMailer.activate(@user).deliver_now
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :email, :password_confirmation)
    end
end
