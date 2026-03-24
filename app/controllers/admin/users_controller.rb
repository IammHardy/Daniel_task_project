class Admin::UsersController < Admin::BaseController
  before_action :set_company
  before_action :load_collections, only: [:new, :create]

 def index
    @users = User.includes(:company, :sector).all
  end
  def new
    @user = User.new
    @user.company = @company if @company
  end

  def create
    @user = User.new(user_params)
    @user.company ||= @company
    if @user.save
      redirect_to admin_company_users_path(@user.company), notice: "User created successfully"
    else
      load_collections
      render :new
    end
  end

  private

  def load_collections
  @companies = Company.all
  @company = Company.find_by(id: params[:company_id])
  @sectors = @company ? @company.sectors : Sector.all
  @managers = @company ? @company.users.where(role: :manager) : User.where(role: :manager)
end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :company_id, :sector_id, :manager_id)
  end

  def set_company
  @company = Company.find(params[:company_id])
end

 
end