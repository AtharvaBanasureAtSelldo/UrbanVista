class CustomersController < ApplicationController
  layout "admin"
  def index
    @customers = Customer.all
    @curtomer_count = @customers.count
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phoneno, :tenant_id)
  end
end
