require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it "creates valid tenant" do
    tenant = FactoryBot.create(:tenant)
    expect(tenant).to be_valid
  end
end