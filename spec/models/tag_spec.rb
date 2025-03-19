require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.create(:tag)
  end

  it "creates a valid tag" do
    expect(@tag).to be_valid
  end

  it "when tag name is nil" do
    @tag.name = nil
    expect(@tag).not_to be_valid
  end

  it "when tenant id is nil" do
    @tag.tenant_id = nil;
    expect(@tag).not_to be_valid
  end
end