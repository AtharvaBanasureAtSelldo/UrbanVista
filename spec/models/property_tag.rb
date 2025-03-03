require 'rails_helper'

RSpec.describe PropertyTag, type: :model do
  it "creates a valid property_tag" do
    property_tag = FactoryBot.create(:property_tag)
    expect(property_tag).to be_valid
  end
end
