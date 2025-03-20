require 'rails_helper'

RSpec.describe PagesController, type: :request do
  let(:tenant) { FactoryBot.create(:tenant) }
  let(:user) { FactoryBot.create(:user, tenant: tenant) }
  context "when user has logged in" do
    before do
      user_params = { email: user.email, password: user.password }
      post '/login', params: user_params
    end

    it "display home page" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end

  context "when user has not logged in" do
    it "display home page" do
      get "/"
      expect(response).to redirect_to(login_path)
    end
  end
end