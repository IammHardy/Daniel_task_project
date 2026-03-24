class Admin::SectorsController < Admin::BaseController
  before_action :set_sector, only: [:edit, :update, :destroy]
  before_action :set_company, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @sectors = @company.sectors
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @sector = @company.sectors.new
  end

  def create
    @sector = @company.sectors.new(sector_params)
    if @sector.save
      respond_to do |format|
        format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector created" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("company_#{@company.id}_frame", partial: "sectors/sectors_list", locals: { sectors: @company.sectors, company: @company }) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sector.update(sector_params)
      respond_to do |format|
        format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector updated" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("company_#{@company.id}_frame", partial: "sectors/sectors_list", locals: { sectors: @company.sectors, company: @company }) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sector.destroy
    respond_to do |format|
      format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector deleted" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("company_#{@company.id}_frame", partial: "sectors/sectors_list", locals: { sectors: @company.sectors, company: @company }) }
    end
  end

  private

  def set_company
    @company = params[:company_id] ? Company.find(params[:company_id]) : @sector.company
  end

  def set_sector
    @sector = Sector.find(params[:id])
  end

  def sector_params
    params.require(:sector).permit(:name)
  end
end