require 'rails_helper'

RSpec.describe AgentsController, type: :request do
  let(:tenant) { FactoryBot.create(:tenant) }
  let(:user) { FactoryBot.create(:user, tenant: tenant) }
  context "when user has logged in" do
    before do
      user_params = { email: user.email, password: user.password  }
      post '/login', params: user_params
    end

    it "display agents" do
      get "/agents"
      expect(response).to render_template(:index)
    end

    it "add agent" do
      post "/agents"
      # 204 indicates not content found
      expect(response).to have_http_status(204)
    end
  end

  context "when user has not logged in" do
    it "display agents" do
      get "/agents"
      expect(response).to redirect_to(login_path)
    end
  end
end