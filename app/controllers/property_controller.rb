class PropertyController < ApplicationController
  before_action :authorize_request, only: [ :show ]

  def index
    @properties = Property.all
  end

  def show
    if current_user.role == "admin"
      render layout: "admin"
    elsif current_user.role == "agent"
      render layout: "agent"
    end
    # @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to root
    else
      render :new
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  private
  def property_params
    params.require(:property).permit(:title, :address, :price, :tenant_id, :user_id)
  end
end
