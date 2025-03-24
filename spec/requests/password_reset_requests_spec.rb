require 'rails_helper'

RSpec.describe PasswordResetsController, type: :request do
  let(:tenant) { FactoryBot.create(:tenant) }
  let(:user) { FactoryBot.create(:user, tenant: tenant) }
  context "password resets" do
    it "try to reset the password" do
      get "/password_resets/new"
      expect(response).to have_http_status(200)
    end

    it "try to get the create" do
      post "/password_resets"
      expect(response).to redirect_to(login_path)
    end
  end
end