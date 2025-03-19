class CustomersService
  def initialize(customer)
    @customer = customer
  end

  def create_customer(params)
    customer = Customer.new(params)
    if customer.save
      { success: true, data: customer }
    else
      { success: false, errors: customer.errors.full_messages }
    end
  end
end