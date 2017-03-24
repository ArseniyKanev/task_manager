class WelcomeController < ApplicationController

  def index
    @tasks = Task.includes(:user).order(created_at: :desc).page(page_parameter)
  end

end
