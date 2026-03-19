class Admin::SectorsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_company, only: [:new, :create]
  before_action :set_sector, only: [:edit, :update, :destroy]

  # GET /admin/sectors
  def index
    @sectors = Sector.all
  end

  # GET /admin/companies/:company_id/sectors/new
  def new
    @sector = @company.sectors.new
  end

  # POST /admin/companies/:company_id/sectors
  def create
    @sector = @company.sectors.new(sector_params)
    if @sector.save
      redirect_to admin_company_path(@company), notice: "Sector created successfully"
    else
      render :new
    end
  end

  # GET /admin/sectors/:id/edit
  def edit; end

  # PATCH/PUT /admin/sectors/:id
  def update
    if @sector.update(sector_params)
      redirect_to admin_company_path(@sector.company), notice: "Sector updated successfully"
    else
      render :edit
    end
  end

  # DELETE /admin/sectors/:id
  def destroy
    company = @sector.company
    @sector.destroy
    redirect_to admin_company_path(company), notice: "Sector deleted"
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_sector
    @sector = Sector.find(params[:id])
  end

  def sector_params
    params.require(:sector).permit(:name)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end