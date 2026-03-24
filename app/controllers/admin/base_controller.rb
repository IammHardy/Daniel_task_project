# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  private

  def ensure_admin!
    redirect_to root_path, alert: "Unauthorized" unless current_user&.admin?
  end
end