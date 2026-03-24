# app/controllers/manager/base_controller.rb
class Manager::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_manager!

  private

  def ensure_manager!
    redirect_to root_path, alert: "Unauthorized" unless current_user&.manager?
  end
end