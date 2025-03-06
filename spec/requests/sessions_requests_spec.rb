require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "#create" do
    context 'when valid user' do
      let(:tenant) { FactoryBot.create(:tenant) }
      let(:user) { FactoryBot.create(:user, tenant: tenant) }

      it "when valid user login" do
        user_params = { email: user.email, password: user.password  }
        post "/login", params: user_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when invalid email' do
      let(:tenant) { FactoryBot.create(:tenant) }
      let(:user) { FactoryBot.create(:user, tenant: tenant) }

      it "when different email is provide" do
        user_params = { email: "banasure@gmail.com", password: user.password  }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when email is nil" do
        user_params = { email: nil, password: user.password  }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when email is empty" do
        user_params = { email: "", password: user.password  }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when email is format is not valid" do
        user_params = { email: "atharvagmail.com", password: user.password  }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when invalid password" do
      let(:tenant) { FactoryBot.create(:tenant) }
      let(:user) { FactoryBot.create(:user, tenant: tenant) }

      it "when password is wrong" do
        user_params = { email: user.email, password: "123" }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when password is nil" do
        user_params = { email: user.email, password: nil }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when password is empty" do
        user_params = { email: user.email, password: "" }
        post "/login", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end