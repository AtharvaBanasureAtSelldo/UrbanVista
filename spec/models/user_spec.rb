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

  it "is not valid without a name" do
    @user1.name = nil
    @user2.name = nil
    expect(@user1).not_to be_valid
    expect(@user2).not_to be_valid
  end

  it "is not valid without an email" do
    @user1.email = nil
    expect(@user1).not_to be_valid
  end

  it "is not valid without a password" do
    @user1.password = nil
    expect(@user1).not_to be_valid
  end
end