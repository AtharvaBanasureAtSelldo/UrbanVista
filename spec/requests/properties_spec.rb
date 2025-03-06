require 'rails_helper'

RSpec.describe PropertiesController, type: :request do
  describe '#index' do
    context 'display all the properties' do
      let(:tenant) { FactoryBot.create(:tenant) }
      let(:user) { FactoryBot.create(:user, tenant: tenant) }

      it "GET /properties" do
        get "/properties"
        expect(response).to have_http_status(200)
      end
    end
  end
end
