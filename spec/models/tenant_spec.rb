require 'rails_helper'

RSpec.describe Tenant, type: :model do

  before do
    @tenant = FactoryBot.create(:tenant)
  end

  it "when valid details provided" do
    expect(@tenant).to be_valid
  end

  it "when tenant name is nil" do
    @tenant.name=nil
    expect(@tenant).not_to be_valid
  end

  it "when "
end