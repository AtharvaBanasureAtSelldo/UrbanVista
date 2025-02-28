class CustomersController < ApplicationController
  before_action :set_layout
  def index
    @customers = Customer.all
    @curtomer_count = @customers.count
    render layout: @layout
  end

  def new
    @customer = Customer.new
    render layout: @layout
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render :new
    end
    render layout: @layout
  end

  private

  def set_layout
    @layout = current_user.role == "admin" ? "admin" : "agent"
  end


  def customer_params
    params.require(:customer).permit(:name, :phoneno, :tenant_id)
  end
end
