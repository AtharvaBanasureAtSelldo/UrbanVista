require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "creates valid customer" do
    customer= FactoryBot.create(:customer)
    expect(customer).to be_valid
  end
end