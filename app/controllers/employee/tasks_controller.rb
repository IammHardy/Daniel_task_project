class Employees::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_employee

  def index
    @tasks = current_user.tasks_as_employee.order(due_date: :asc)
  end

  def show
    @task = current_user.tasks_as_employee.find(params[:id])
  end

  private

  def ensure_employee
    redirect_to root_path, alert: "Access denied" unless current_user.employee?
  end
end