class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @companies = Company.includes(:users, :sectors).all
  end


  private

  def ensure_admin!
  redirect_to manager_root_path, alert: "Not authorized" unless current_user.admin?
end

end