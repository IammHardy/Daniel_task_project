class Admin::UsersController < Admin::BaseController
  before_action :set_company
  before_action :load_collections, only: [:new, :create]

  def index
    @users = @company.users.includes(:company, :sector)
  end

  def new
    @user = @company.users.new
  end

 def create
  @user = @company.users.build(user_params)

  if @user.save
    redirect_to admin_company_users_path(@company), notice: "User created successfully."
  else
    flash.now[:alert] = "Please fix the errors below."
    render :new, status: :unprocessable_entity
  end
end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def load_collections
    @sectors = @company.sectors
    @managers = @company.users.where(role: :manager)
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :role,
      :sector_id,
      :manager_id
    )
  end
end