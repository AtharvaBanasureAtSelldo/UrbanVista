class PropertiesController < ApplicationController
  before_action :authorize_request, only: [ :show ]

  def index
    @properties = Property.all
  end

  def defaultpage
  end

  def destroy
    @property = Property.find(params[:id])
    @property.appointments.destroy_all 

    @property.user_id=nil
    @property.tenant_id=nil
    @property.destroy
    redirect_to properties_path, notice: "Property deleted Successfully"
  end


  def show
    @property = Property.find(params[:id])
    # TODO: Use safer way to find: find_by(id: params[:id])
    if current_user.role == "admin"
      render layout: "admin"
    elsif current_user.role == "agent"
      render layout: "agent"
    end
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @property=Property.find(params[:id])
    @tags=Tag.all
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: "Property updated Successfully"
    else
      render turbo_stream: turbo_stream.replace(
        "property_form",
        partial: "form",
        locals: { property: @property }
      ), status: :unprocessable_entity
    end
  end

 
  private
  def property_params
    params.require(:property).permit(:title, :address, :price, :tenant_id, :user_id)
  end
end
