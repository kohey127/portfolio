class Public::AppointmentsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @comming_appointments = Appointment.where(to_customer_id: current_customer.id, status: "applying").includes(:service)
    @waiting_review_appointments = Appointment.where(to_customer_id: current_customer.id, status: "success").includes(:service)
    @applying_appointments = Appointment.where(from_customer_id: current_customer.id, status: "applying").includes(:service)
    @success_appointments = Appointment.where(from_customer_id: current_customer.id, status: "success").includes(:service)
    @failure_appointments = Appointment.where(from_customer_id: current_customer.id, status: "failure", created_at: 3.day.ago.beginning_of_day..Time.zone.now.end_of_day).includes(:service)
    @done_appointments = Appointment.where(from_customer_id: current_customer.id, status: "done").includes(:service)
  end

  def create
    # 仮予約新規作成
    appointment = Appointment.new(appointment_params)
    appointment.status = "applying"
    if params[:request_date_exist] == "0"
      appointment.request_date = "undecided"
    else
      appointment.request_date = params[:appointment][:request_date]
    end
    appointment.save!
    # コメント新規作成
    appointment_comment = AppointmentComment.new
    appointment_comment.customer_id = current_customer.id
    appointment_comment.appointment_id = appointment.id
    appointment_comment.content = params[:first_message]
    appointment_comment.save
    redirect_to service_appointments_complete_path
  end

  def new
    @appointment = Appointment.new
    @service = Service.find(params[:service_id])
  end

  def complete
  end

  def update
    appointment = Appointment.find(params[:id])
    case params[:update_param]
      when "success"
        appointment.success!
      when "failure"
        appointment.failure!
    end
    redirect_to appointments_path
  end

  def destroy

  end

  private
  def appointment_params
    params.require(:appointment).permit(:service_id, :to_customer_id, :from_customer_id, :request_format, :request_date, :status)
  end
end
