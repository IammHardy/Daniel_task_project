class ApplicationController < ActionController::Base
  # Only run for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Keep this if you want modern browser checks
  allow_browser versions: :modern

  # Redirect users after sign in based on role
 def after_sign_in_path_for(user)
  return admin_root_path if user.admin?
  return manager_dashboard_index_path if user.manager?

  employee_dashboard_index_path
end

  protected

  # Permit extra Devise params safely
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_id, :sector_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company_id, :sector_id])
  end
end