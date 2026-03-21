class Manager::TasksController < Manager::BaseController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.where(manager_id: current_user.id)
  end

  def new
    @task = Task.new
    @employees = current_user.employees
    @sectors = current_user.company.sectors
  end

  def create
    @task = Task.new(task_params)
    @task.manager_id = current_user.id
    @task.company_id = current_user.company_id

    if @task.save
      respond_to do |format|
        format.html { redirect_to manager_tasks_path, notice: "Task created" }
        format.turbo_stream
      end
    else
      @employees = current_user.employees
      @sectors = current_user.company.sectors
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employees = current_user.employees
    @sectors = current_user.company.sectors
  end

  def update
    if @task.update(task_params)
      redirect_to manager_tasks_path, notice: "Task updated"
    else
      @employees = current_user.employees
      @sectors = current_user.company.sectors
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to manager_tasks_path, notice: "Task deleted"
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :employee_id, :sector_id, :status, :priority, :due_date)
  end
end