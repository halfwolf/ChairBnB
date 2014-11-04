class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["Email or Password is Incorrect"]
      render :new
    else
      login_user!(@user)
      redirect_to "#/dashboard"
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

end
