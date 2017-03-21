class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound, with: ->(e) { rescue_catcher(e, I18n.t('wrong_url'), 404) }

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def page_parameter(param_name = :page)
    params[param_name].to_i > 0 ? params[param_name].to_i : 1
  end

end
