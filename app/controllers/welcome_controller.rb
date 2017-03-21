class WelcomeController < ApplicationController

  def index
    @tasks = Task.preload(:user).order('created_at DESC').load
  end

end
