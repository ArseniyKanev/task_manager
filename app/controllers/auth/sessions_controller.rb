class Auth::SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash[:danger] = ["Wrong email or password"]
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
