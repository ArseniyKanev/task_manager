class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def auth
    unless user_signed_in?
      flash[:danger] = "Not signed in"
      redirect_to request.fullpath and return
    end
  end

  private

  def page_parameter(param_name = :page)
    params[param_name].to_i > 0 ? params[param_name].to_i : 1
  end

end
