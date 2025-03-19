require 'rails_helper'

RSpec.describe PropertiesController, type: :request do
  describe 'display properties' do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant) }
    let(:property) { FactoryBot.create(:property, tenant: tenant, user: user) }
    context 'when user has logged in' do
      before do
        user_params = { email: user.email, password: user.password  }
        post '/login', params: user_params
      end

      it "all properties" do
        get "/properties"
        expect(response).to have_http_status(200)
      end

      it "when valid property id is provided" do
        get "/properties/#{property.id}"
        expect(response).to have_http_status(200)
      end

      it "when invalid property id is provided" do
        get "/properties/1"
        expect(response).to redirect_to(properties_path)
      end

      it "when invalid property id is provided" do
        get "/properties/-1"
        expect(response).to redirect_to(properties_path)
      end

      it "when property belongs to different tenant" do
        other_tenant = FactoryBot.create(:tenant)
        other_tenant.id = 78
        other_property = FactoryBot.create(:property, tenant: other_tenant)
        get "/properties/#{other_property.id}"
        expect(response).to redirect_to(properties_path)
      end
    end

    context "when user is not logged in" do
      it "GET /properties" do
        get "/properties"
        expect(response).to redirect_to(login_path)
      end

      it "when valid property id is provided" do
        get "/properties/#{property.id}"
        expect(response).to redirect_to(login_path)
      end

      it "when invalid property id is provided" do
        get "/properties/1"
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'create property' do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant) }
    let(:property) { FactoryBot.create(:property, user: user, tenant: tenant) }
    context "when user logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "render the form for create property" do
        get "/properties/new"
        expect(response).to have_http_status(200)
      end

      it "fill the valid form details for create property" do
        property_params = {
          property: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            address: property.address,
            price: property.price
          }
        }
        post "/properties", params: property_params
        expect(response).to redirect_to(properties_path)
      end
    end

    context "when user logged out" do
      let(:tenant) { FactoryBot.create(:tenant) }
      let(:user) { FactoryBot.create(:user, tenant: tenant) }
      let(:property) { FactoryBot.create(:property,user: user, tenant: tenant) }
      it "render the form for create property" do
        get "/properties/new"
        expect(response).to redirect_to(login_path)
      end

      # "TODO: FIX merge(user_id: current_user.id)"

      # it "filled the valid form details for create property" do
      #   property_params = {
      #     property: {
      #       user_id: user.id,
      #       tenant_id: tenant.id,
      #       title: property.title,
      #       address: property.address,
      #       price: property.price
      #     }
      #   }
      #   post "/properties", params: property_params
      #   expect(response).to redirect_to(root_path)
      # end
    end
  end


  describe 'destroy property' do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant) }
    let(:property) { FactoryBot.create(:property, tenant: tenant, user: user) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "when valid propertyID provided" do
        delete "/properties/#{property.id}"
        expect(response).to redirect_to(properties_path)
      end

      it "when invalid propertyID provided" do
        delete "/properties/1"
        expect(response).to have_http_status(404)
      end
    end


    context "when user is not logged in" do
      it "when valid propertyID provided" do
        delete "/properties/#{property.id}"
        expect(response).to redirect_to(login_path)
      end

      it "when invalid propertyID provided" do
        delete "/properties/1"
        expect(response).to redirect_to(login_path)
      end
    end
  end


  describe "edit property" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant) }
    let(:property) { FactoryBot.create(:property, tenant: tenant, user: user) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "when valid propertyID provided" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(properties_path)
      end

      it "when invalid propertyID provided" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/1", params: property_params
        expect(response).to redirect_to(properties_path)
      end

      it "when title is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: nil,
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when address is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: nil,
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when price is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  nil
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when title is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when address is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Title",
            address: "",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "when price is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "est Title",
            address: "Test Nagpur",
            price: 0
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user has not logged in" do
      it "when valid propertyID provided" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when invalid propertyID provided" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/1", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when title is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: nil,
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when address is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: nil,
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when price is nil" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Property 222",
            address: "Test Nagpur",
            price:  nil
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when title is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "",
            address: "Test Nagpur",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when address is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "Test Title",
            address: "",
            price:  10000000
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end

      it "when price is empty" do
        property_params = {
          property: {
            tenant_id: tenant.id,
            user_id: user.id,
            title: "est Title",
            address: "Test Nagpur",
            price: 0
          }
        }
        put "/properties/#{property.id}", params: property_params
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
