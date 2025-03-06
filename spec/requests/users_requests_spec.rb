require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:tenant) { FactoryBot.create(:tenant)}
  let(:user) { FactoryBot.create(:user, tenant: tenant)}
  describe "User Signup" do

    context "when valid details provided" do
      it "creates new User" do
        user_params = { user: { name: "Atharva Banasure", email: "atharvabanasure@gmail.com", role: "admin", phone: "9009090909", password: "123456", tenant_id: tenant.id } }
        post "/signup", params: user_params
        expect(response).to redirect_to(login_path)
      end
    end

    context "when invalid email provided" do
      it "when email is nil" do
        user_params = { user: { name: user.name, email: nil, role: user.role, phone: user.phone, password: user.password, tenant_id: tenant.id } } 
        post "/signup", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when email is empty" do
        user_params = { user: { name: user.name, email: "", role: user.role, phone: user.phone, password: user.password, tenant_id: tenant.id } } 
        post "/signup", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when email is invalid" do
        user_params = { user: { name: user.name, email: "athavagmail", role: user.role, phone: user.phone, password: user.password, tenant_id: tenant.id } } 
        post "/signup", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      #TODO: Change the EMAIL regex since it does not have .

      # it "when email does not have . " do
      #   user_params = { user: { name: user.name, email: "athava@gmail", role: user.role, phone: user.phone, password: user.password, tenant_id: tenant.id } } 
      #   post "/signup", params: user_params
      #   expect(response).to have_http_status(:unprocessable_entity)
      # end

      it "when email does not have @" do
        user_params = { user: { name: user.name, email: "atharva.com", role: user.role, phone: user.phone, password: user.password, tenant_id: tenant.id } } 
        post "/signup", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end