require 'rails_helper'

RSpec.describe AppointmentsController, type: :request do
  describe "display appointment" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant)}
    let(:customer) { FactoryBot.create(:customer, tenant: tenant) }
    let(:appointment) { FactoryBot.create(:appointment, tenant: tenant, user: user, customer: customer) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "all appointments" do
        get "/appointments"
        expect(response).to have_http_status(200)
      end

      it "when valid appointment id provided" do
        get "/appointments/#{appointment.id}"
        expect(response).to have_http_status(200)
      end

      it "when invalid appointment id provided" do
        get "/appointments/-1"
        expect(response).to redirect_to(appointments_path)
      end
    end

    context "when user has not logged in" do
      it "all appointments" do
        get "/appointments"
        expect(response).to redirect_to(login_path)
      end

      it "when valid appointment id provided" do
        get "/appointments/#{appointment.id}"
        expect(response).to redirect_to(login_path)
      end

      it "when invalid appointment id provided" do
        get "/appointments/-1"
        expect(response).to redirect_to(login_path)
      end
    end
  end


  describe "create appointment" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant)}
    let(:property) { FactoryBot.create(:property, tenant: tenant, user: user) }
    let(:customer) { FactoryBot.create(:customer, tenant: tenant) }
    let(:appointment) { FactoryBot.create(:appointment, tenant: tenant, user: user, customer: customer) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "render the appointment create form" do
        get "/appointments/new"
        expect(response).to have_http_status(200)
      end

      it "fill the valid form details for appointment form" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        post "/appointments", params: appointment_params
        expect(response).to have_http_status(200)
      end
    end

    context "when user has not logged in" do
      it "render the appointment create form" do
        get "/appointments/new"
        expect(response).to redirect_to(login_path)
      end

      it "fill the valid form details for appointment form" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }

        post "/appointments", params: appointment_params
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "delete appointment" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant)}
    let(:customer) { FactoryBot.create(:customer, tenant: tenant) }
    let(:appointment) { FactoryBot.create(:appointment, tenant: tenant, user: user, customer: customer) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "when valid appointment id provided" do
        delete "/appointments/#{appointment.id}"
        expect(response).to redirect_to(appointments_path)
      end

      it "when invalid property id provided" do
        delete "/appointments/-1"
        expect(response).to redirect_to(appointments_path)
      end
    end

    context "when user has not logged in" do
      it "when valid appointment id provided" do
        delete "/appointments/#{appointment.id}"
        expect(response).to redirect_to(login_path)
      end

      it "when invalid property id provided" do
        delete "/appointments/-1"
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "edit appointment" do
    let(:tenant) { FactoryBot.create(:tenant) }
    let(:user) { FactoryBot.create(:user, tenant: tenant)}
    let(:property) { FactoryBot.create(:property, tenant: tenant, user: user) }
    let(:customer) { FactoryBot.create(:customer, tenant: tenant) }
    let(:appointment) { FactoryBot.create(:appointment, tenant: tenant, user: user, customer: customer) }

    context "when user has logged in" do
      before do
        user_params = { email: user.email, password: user.password }
        post "/login", params: user_params
      end

      it "when valid appointment id provided" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/#{appointment.id}", params: appointment_params
        expect(response).to redirect_to(appointments_path)
      end

      it "when invalid appointment id provided" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/-1", params: appointment_params
        expect(response).to redirect_to(appointments_path)
      end

      it "when Agent user_id is invalid" do
        appointment_params = {
          appointment: {
            user_id: 10000,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/#{appointment.id}", params: appointment_params
        expect(response).to have_http_status(200)
      end
    end

    context "when user has not logged in" do
      it "when valid appointment id provided" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/#{appointment.id}", params: appointment_params
        expect(response).to redirect_to(login_path)
      end

      it "when invalid appointment id provided" do
        appointment_params = {
          appointment: {
            user_id: user.id,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/-1", params: appointment_params
        expect(response).to redirect_to(login_path)
      end

      it "when Agent user_id is invalid" do
        appointment_params = {
          appointment: {
            user_id: 10000,
            tenant_id: tenant.id,
            title: property.title,
            customer_id: customer.id,
            date: Date.today,
            time: Time.now
          }
        }
        put "/appointments/#{appointment.id}", params: appointment_params
        expect(response).to redirect_to(login_path)
      end
    end
  end
end