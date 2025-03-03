require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "creates a valid tag" do
    tag = FactoryBot.create(:tag)
    expect(tag).to be_valid
  end
end
