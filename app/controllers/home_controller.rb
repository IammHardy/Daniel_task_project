class HomeController < ApplicationController
  def index
  end

 def redirect_by_role
  case current_user.role
  when "admin"
    redirect_to admin_root_path
  when "manager"
    redirect_to manager_dashboard_path
  when "employee"
    redirect_to employee_dashboard_path
  else
    sign_out current_user
    redirect_to root_path, alert: "Role not assigned."
  end
end
end