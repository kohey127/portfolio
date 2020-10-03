class Public::AppointmentsController < ApplicationController
  def index
    
  end

  def create
      # 仮予約新規作成
      appointment = Appointment.new(appointment_params)
      appointment.from_customer_id = current_customer.id
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
      appointment_comment.save!
      redirect_to service_appointments_complete_path
  end

  def new
    @appointment = Appointment.new
    @service = Service.find(params[:service_id])
  end

  def complete

  end
  private
  def appointment_params
    params.require(:appointment).permit(:customer_id, :service_id, :from_customer_id, :request_format, :request_date, :status)
  end

  def appointment_comment_params
    params.require(:appointment_comment).permit(:customer_id, :appointment_id, :content)
  end
end
