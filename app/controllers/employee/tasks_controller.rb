class Employee::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_employee
  before_action :set_task, only: [:show, :update]

  def index
    @tasks = current_user.tasks_as_employee.order(due_date: :asc)
  end

  def show
    # @task is set in set_task
  end

  def update
    # For marking as completed
    if @task.update(completed: true)
      respond_to do |format|
        format.html { redirect_to employee_tasks_path, notice: "Task marked completed." }
        format.turbo_stream
      end
    else
      redirect_to employee_tasks_path, alert: "Could not update task."
    end
  end

  def upload
  @task = current_user.tasks_as_employee.find(params[:id])
  @task.documents.attach(params[:task][:documents])
  redirect_to employee_task_path(@task), notice: "Document uploaded."
end

def request_extension
  @task = current_user.tasks_as_employee.find(params[:id])
  # mark the task as requested for extension (add a boolean or comment in DB)
  @task.update(extension_requested: true)
  redirect_to employee_task_path(@task), notice: "Deadline extension requested."
end

  private

  def ensure_employee
    redirect_to root_path, alert: "Access denied" unless current_user.employee?
  end

  def set_task
    @task = current_user.tasks_as_employee.find_by(id: params[:id])
    redirect_to employee_tasks_path, alert: "Task not found." unless @task
  end
end