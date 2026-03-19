class Admin::CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_company, only: [ :edit, :update, :destroy]

  # GET /admin/companies
  def index
    @companies = Company.all
  end

  def sectors
  company = Company.find(params[:id])
  render json: company.sectors.select(:id, :name)
end
  # GET /admin/companies/new
  def new
    @company = Company.new
  end

  # POST /admin/companies
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to admin_companies_path, notice: "Company created successfully"
    else
      render :new
    end
  end

  # GET /admin/companies/:id/edit
  def edit; end

  # PATCH/PUT /admin/companies/:id
  def update
    if @company.update(company_params)
      redirect_to admin_companies_path, notice: "Company updated successfully"
    else
      render :edit
    end
  end

  # DELETE /admin/companies/:id
  def destroy
    @company.destroy
    redirect_to admin_companies_path, notice: "Company deleted"
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end