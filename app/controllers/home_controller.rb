class HomeController < ApplicationController
  def index
  end

  def redirect_by_role
    return redirect_to new_user_session_path unless user_signed_in?

    case current_user.role
    when "admin"
      redirect_to admin_root_path
    when "manager"
      redirect_to manager_root_path
    when "employee"
      redirect_to employee_root_path
    else
      sign_out current_user
      redirect_to new_user_session_path, alert: "Invalid role"
    end
  end
end