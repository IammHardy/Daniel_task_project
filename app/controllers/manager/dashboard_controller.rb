class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_manager

  def index
  end

  private

  def require_manager
    redirect_to root_path unless current_user.manager?
  end
end