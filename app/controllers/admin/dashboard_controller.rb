class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
      @companies = Company.includes(:users, :sectors)
     # Totals for dashboard cards
    @total_companies = Company.count
    @total_sectors = Sector.count
    @total_managers = User.where(role: "manager").count
  end


  private

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end