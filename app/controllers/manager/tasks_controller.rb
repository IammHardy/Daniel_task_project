class Manager::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_manager!

  def index
    @tasks = current_user.tasks_as_manager.includes(:employee, :sector).order(created_at: :desc)
  end

  def new
    @task = Task.new
    load_collections
  end

  def create
    @task = Task.new(task_params)
    @task.manager = current_user
    @task.company = current_user.company

    if @task.save
      redirect_to manager_tasks_path, notice: "Task assigned successfully."
    else
      load_collections
      render :new
    end
  end

  private

  def ensure_manager!
    redirect_to root_path, alert: "Unauthorized" unless current_user.manager?
  end

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :employee_id,
      :sector_id,
      :priority,
      :due_date
    )
  end

  def load_collections
    # Only employees under this manager & company
    @employees = current_user.employees.includes(:sector)

    # Only sectors in manager's company
    @sectors = current_user.company.sectors
  end
end