class Admin::CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to admin_companies_path, notice: "Company created!"
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def ensure_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end