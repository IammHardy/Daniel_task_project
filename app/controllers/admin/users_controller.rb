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
  @user = @company.users.build(user_params)

  respond_to do |format|
    if @user.save
      format.turbo_stream { render turbo_stream: turbo_stream.prepend("users_list", partial: "admin/users/user", locals: { user: @user }) }
      format.html { redirect_to admin_company_users_path(@company), notice: "User created" }
    else
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_user_form", partial: "admin/users/form", locals: { user: @user, company: @company, sectors: @sectors, managers: @managers }) }
      format.html { render :new, status: :unprocessable_entity }
    end
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