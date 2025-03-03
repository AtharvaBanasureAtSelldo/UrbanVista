require 'rails_helper'

RSpec.describe Property, type: :model do
  it "creates a valid property" do
    property = FactoryBot.create(:property)
    expect(property).to be_valid
  end
end