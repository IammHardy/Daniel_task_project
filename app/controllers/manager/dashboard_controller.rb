class Manager::DashboardController < Manager::BaseController
  before_action :authenticate_user!

  def index
  end

end