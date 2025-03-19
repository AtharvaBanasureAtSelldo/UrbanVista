class CustomersController < ApplicationController
  before_action :set_layout
  def index
    @customers = policy_scope(Customer).order(created_at: :desc)
    authorize Customer
    @curtomer_count = @customers.count
    render layout: @layout
  end

  def new
    @customer = Customer.new
    render layout: @layout
  end

  def create
    result = CustomersService.new(Customer).create_customer(customer_params)
    if result[:success]
      redirect_to customers_path
    else
      render :new
    end
  end

  private

  def set_layout
    @layout = current_user.role == "admin" ? "admin" : "agent"
  end


  def customer_params
    params.require(:customer).permit(:name, :phoneno, :tenant_id)
  end
end
