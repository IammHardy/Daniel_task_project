class ApplicationController < ActionController::Base
  # Devise params
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

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
    redirect_to root_path, alert: "Role not assigned. Contact admin."
  end
end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :company_id, :sector_id, :manager_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :company_id, :sector_id, :manager_id])
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Unauthorized" unless current_user&.admin?
  end

  def ensure_manager!
    redirect_to root_path, alert: "Unauthorized" unless current_user&.manager?
  end
end