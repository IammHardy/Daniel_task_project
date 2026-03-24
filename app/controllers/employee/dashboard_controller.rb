class Employee::DashboardController < Employee::BaseController
  before_action :authenticate_user!
  before_action :ensure_employee!

  def index
    # Only show tasks assigned to the current employee
    @tasks = current_user.tasks_as_employee.includes(:manager, :sector, :company).order(created_at: :desc)
  end

  private

  def ensure_employee!
    redirect_to root_path, alert: "Unauthorized" unless current_user.employee?
  end
end