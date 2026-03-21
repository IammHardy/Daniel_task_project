class Admin::SectorsController < Admin::BaseController
  before_action :set_company, only: [:new, :create]
  before_action :set_sector, only: [:edit, :update, :destroy]

  def index
    @sectors = Sector.where(company_id: params[:company_id])
  end

  def new
    @sector = Sector.new
  end

  def create
    @sector = Sector.new(sector_params)
    @sector.company_id = @company.id

    if @sector.save
      redirect_to admin_company_sectors_path(@company), notice: "Sector created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sector.update(sector_params)
      redirect_to admin_company_sectors_path(@sector.company), notice: "Sector updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sector.destroy
    redirect_to admin_company_sectors_path(@sector.company), notice: "Sector deleted"
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
end