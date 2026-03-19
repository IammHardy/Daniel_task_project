class Employee::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_employee

  def index
  end

  private

  def require_employee
    redirect_to root_path unless current_user.employee?
  end
end