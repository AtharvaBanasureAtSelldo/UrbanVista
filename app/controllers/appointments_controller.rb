class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_request
  before_action :set_layout
  before_action :set_customers_and_agents, only: [:new, :edit]

  def index
    @appointments = policy_scope(Appointment).order(date: :desc)
    authorize Appointment
    render layout: @layout
  end

  def show
    authorize @appointment
    render layout: @layout
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
    render layout: @layout
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment created successfully"
    else
      flash.now[:alert] = @appointment.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    authorize @appointment
    render layout: @layout
    rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found"
  end

  def update
    authorize @appointment
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated successfully"
    else
      flash.now[:alert] = @appointment.errors.full_messages.to_sentence
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
    params.require(:appointment).permit(:user_id, :customer_id, :property_id, :date, :time).merge(tenant_id: current_user.tenant_id)
  end

  def set_layout
    @layout = current_user.role == "admin" ? "admin" : "agent"
  end
end
