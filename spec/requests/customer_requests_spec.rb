require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  describe "display customer" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user) }

    context "when user logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "display all the customers" do
        get "/customers"
        expect(response).to have_http_status(200)
      end

      it "get the create customer form" do
        get "/customers/new"
        expect(response).to have_http_status(200)
      end

      it "fill the valid create customer form" do
        customer_params = {
          customer: {
            tenant_id: tenant.id,
            name: "Test Customer 1",
            phoneno: "9089098789"
          }
        }
        post "/customers", params: customer_params
        expect(response).to redirect_to(customers_path)
      end
    end

    context "when user logged out" do
      it "display all the customers" do
        get "/customers"
        expect(response).to redirect_to(login_path)
      end

      it "get the create customer form" do
        get "/customers/new"
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

