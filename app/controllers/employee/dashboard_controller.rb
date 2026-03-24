class Employee::DashboardController < Employee::BaseController
  before_action :authenticate_user!
  before_action :ensure_employee!

  def index
    @tasks = current_user.tasks_as_employee.order(due_date: :asc)
  end

  private

  def ensure_employee!
    redirect_to root_path, alert: "Unauthorized" unless current_user.employee?
  end
end