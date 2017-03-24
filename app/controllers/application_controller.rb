class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: ->(e) { rescue_catcher }

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def auth
    unless user_signed_in?
      flash[:danger] = [I18n.t('auth.errors.not_signed_in')]
      redirect_to new_session_path and return
    end
  end

  def no_auth
    if user_signed_in?
      flash[:danger] = [I18n.t('auth.errors.already_signed_in')]
      redirect_to root_path
    end
  end

  private

  def page_parameter(param_name = :page)
    params[param_name].to_i.positive? ? params[param_name].to_i : 1
  end

  def rescue_catcher()
    flash[:danger] = [I18n.t('auth.errors.no_permissions')]
    redirect_to root_path and return
  end

end
