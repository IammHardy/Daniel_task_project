class ApplicationController < ActionController::Base
  # Devise params
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    case resource.role
    when "admin"
      admin_root_path
    when "manager"
      manager_root_path
    when "employee"
      employee_root_path
    else
      root_path
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