require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = FactoryBot.create(:user1)
    @user2 = FactoryBot.create(:user2)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
    expect(@user2).to be_valid
  end
end