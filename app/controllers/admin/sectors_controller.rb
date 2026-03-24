class Admin::SectorsController < Admin::BaseController
  before_action :set_company, only: [:index, :new, :create]
  before_action :set_sector, only: [:edit, :update, :destroy]
  before_action :load_collections, only: [:new, :create]

  def index
    # Load the company so @company is available in the view
    @sectors = @company.sectors
  end

  def new
    @sector = @company.sectors.build
  end

 def create
  @sector = @company.sectors.build(sector_params)

  if @sector.save
    respond_to do |format|
      format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector created" }
      format.turbo_stream
    end
  else
    render :new, status: :unprocessable_entity
  end
end

  def edit; end

  # app/controllers/admin/sectors_controller.rb
def update
  if @sector.update(sector_params)
    respond_to do |format|
      format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector updated" }
      format.turbo_stream do
        @company = @sector.company
        @sectors = @company.sectors
        render turbo_stream: turbo_stream.replace("company_#{@company.id}_frame", partial: "sectors_list", locals: { sectors: @sectors, company: @company })
      end
    end
  else
    render :edit, status: :unprocessable_entity
  end
end

 # app/controllers/admin/sectors_controller.rb
def destroy
  @sector.destroy

  respond_to do |format|
    format.html { redirect_to admin_company_sectors_path(@company), notice: "Sector deleted" }
    format.turbo_stream
  end
end

  private

  def load_collections
    @companies = Company.all
  end

  def set_company
    # Find company from params[:company_id], or from @sector.company if needed
    @company = if params[:company_id]
                 Company.find(params[:company_id])
               elsif @sector
                 @sector.company
               end
  end

  def set_sector
    @sector = Sector.find(params[:id])
  end

  def sector_params
    params.require(:sector).permit(:name)
  end
end
  