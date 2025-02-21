class PropertiesController < ApplicationController
  before_action :authorize_request, only: [ :show ]

  def index
    @properties = Property.all
  end

  def defaultpage
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

  private
  def property_params
    params.require(:property).permit(:title, :address, :price, :tenant_id, :user_id)
  end
end
