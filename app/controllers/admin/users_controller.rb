# app/controllers/admin/users_controller.rb
class Admin::UsersController < Admin::BaseController
  before_action :set_company, only: [:index, :new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /admin/companies/:company_id/users
  def index
    @users = @company.users
  @user = @company.users.new 
  end
  

  # GET /admin/companies/:company_id/users/new
  def new
    @user = @company.users.new
    load_collections
  end

  # POST /admin/companies/:company_id/users
  def create
    @user = @company.users.new(user_params)
    if @user.save
      redirect_to admin_company_users_path(@company), notice: "User created successfully."
    else
      load_collections
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  # GET /admin/users/:id/edit
  def edit
    load_collections
  end

  # PATCH/PUT /admin/users/:id
  def update
    if @user.update(user_params)
      redirect_to admin_company_users_path(@user.company), notice: "User updated successfully."
    else
      load_collections
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  # DELETE /admin/users/:id
  def destroy
    company = @user.company
    @user.destroy
    redirect_to admin_company_users_path(company), notice: "User deleted."
  end

  private

  # Load user by ID (shallow route)
  def set_user
    @user = User.find(params[:id])
  end

  # Load company for nested routes
  def set_company
    @company = Company.find(params[:company_id])
  end

  # Permit user parameters
  def user_params
    params.require(:user).permit(:name, :email, :role, :company_id, :sector_id, :manager_id)
  end

  # Load collections for dropdowns
  def load_collections
    @companies = Company.all
    @sectors = @company ? @company.sectors : Sector.all
    @managers = @company ? @company.users.manager : User.manager
  end
end