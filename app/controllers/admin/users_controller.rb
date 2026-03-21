class Admin::UsersController < Admin::BaseController
  before_action :set_company, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.where(company_id: params[:company_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.company_id = @company.id

    if @user.save
      respond_to do |format|
        format.html { redirect_to admin_company_users_path(@company), notice: "User created successfully" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_company_users_path(@user.company), notice: "User updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_company_users_path(@user.company), notice: "User deleted successfully"
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :sector_id, :manager_id, :password, :password_confirmation)
  end
end