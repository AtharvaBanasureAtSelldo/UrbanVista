class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_request
  before_action :set_customers_and_agents, only: [:new, :edit]

  def index
    @appointments = policy_scope(Appointment).order(date: :desc)
    authorize Appointment
  end

  def show
    authorize @appointment
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment created successfully"
    else
      render :new
    end
  end

  def edit
    authorize @appointment
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  def update
    authorize @appointment
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated successfully"
    else
      render :edit
    end
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  def destroy
    authorize @appointment
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully"
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_customers_and_agents
    @customers = Customer.all
    @agents = User.where(role: "agent")
  end

  def appointment_params
    params.require(:appointment).permit(:date, :time, :customer_id, :property_id).merge(user_id: current_user.id)
  end
end
