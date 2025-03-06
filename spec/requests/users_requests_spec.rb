require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:tenant) { FactoryBot.create(:tenant)}
  let!(:user) { FactoryBot.create(:user, tenant: tenant)}
  describe "User Signup" do
    context "POST /signup" do
      it "creates new User" do
        user_params = {user: {name: "Atharva Banasure", email: "atharvabanasure@gmail.com", role: "admin", phone: "9009089786", password: "123456", tenant_id:tenant.id }}
        post "/signup", params: user_params
        expect(response).to redirect_to(login_path)
      end
    end
  end
end