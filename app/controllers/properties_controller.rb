class PropertiesController < ApplicationController
  before_action :authorize_request, only: [ :show, :index ]
  before_action :authenticate_user
  before_action :set_layout
  def index
    @properties = policy_scope(PropertiesService.list_all_properties(current_user))
    authorize Property
    stats = PropertiesService.property_statistics
    @property_count = stats[:property_count]
    @agent_count = stats[:agent_count]
    render layout: @layout
  end

  def destroy
    @property = PropertiesService.fetch_property(params[:id])
    authorize @property
    # TODO : Fix any foreign key constraints dependency
    @property.appointments.destroy_all
    @property.user_id = nil
    @property.tenant_id = nil
    @property.destroy
    redirect_to properties_path, notice: "Property deleted Successfully"
  end

  def show
    begin
      # @property = Property.find(params[:id])
      @property = PropertiesService.fetch_property(params[:id])
      authorize @property # independent of the service
      render layout: @layout #independent of the service
    rescue ActiveRecord::RecordNotFound
      redirect_to properties_path, alert: "Property not found"
    end
  end

  def new
    @property = Property.new
    authorize @property
    render layout: @layout
  end

  def create
    @property = Property.new(property_params)
    authorize @property

    if @property.save
      redirect_to properties_path, notice: "Property created successfully"
    else
      render :new
    end
  end

  def edit
    @property = PropertiesService.fetch_property(params[:id])
    @tags = Tag.all
    authorize @property
    render layout: @layout
  rescue ActiveRecord::RecordNotFound
    redirect_to properties_path, alert: "Property not found"
  end

  def update
    @property = PropertiesService.fetch_property(params[:id])
    authorize @property
    if @property.update(property_params)
      redirect_to properties_path, notice: "Property updated Successfully"
    else
      render turbo_stream: turbo_stream.replace(
        "property_form",
        partial: "form",
        locals: { property: @property }
      ), status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to properties_path, alert: "Property not found"
  end

  private

  def set_layout
    @layout = current_user&.role == "admin" ? "admin" : "agent"
  end

  def property_params
    params.require(:property).permit(:title, :address, :price, :tenant_id).merge(user_id: current_user.id)
  end
end
