require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "#create" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant) }

    context "when valid credentials are provided" do
      it "logs in the user and redirects to the root path" do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
        expect(response).to redirect_to(root_path)
        expect(cookies[:jwt]).not_to be_nil
      end
    end

    context "when invalid email is provided" do
      it "renders the login page with an error" do
        user_params = { email: "invalid@example.com", password: user.password }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or Password")
      end
    end

    context "when invalid password is provided" do
      it "renders the login page with an error" do
        user_params = { email: user.email, password: "wrongpassword" }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or Password")
      end
    end

    context "when email is missing" do
      it "renders the login page with an error" do
        user_params = { email: nil, password: user.password }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or Password")
      end
    end

    context "when password is missing" do
      it "renders the login page with an error" do
        user_params = { email: user.email, password: nil }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Invalid Email or Password")
      end
    end
  end

  # describe "#destroy" do
  #   let(:tenant) { FactoryBot.create(:tenant) }
  #   let(:user) { FactoryBot.create(:user, tenant: tenant) }

  #   before do
  #     user_params = { email: user.email, password: user.password }
  #     post "/login", params: user_params
  #   end

  #   context "when the user is logged in" do
  #     token = JWT.encode({ user_id: user.id }, "my$ecretK3")
  #     cookies.signed[:jwt] = { value: token, httponly: true }

  #     delete "/logout"
  #     expect(response).to redirect_to(root_path)
  #     expect(cookies[:jwt]).to be_nil
  #   end

    # context "when the user is not logged in" do
    #   token = JWT.encode({ user_id: user.id }, "my$ecretK3")
    #   cookies.signed[:jwt] = { value: token, httponly: true }

      
    # end
  # end
end