class Public::AppointmentCommentsController < ApplicationController
  def index
    @appointments = Appointment.where("to_customer_id OR from_customer_id", current_customer.id, current_customer.id).includes(:appointment_comment)
  end

  def show
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id])
    @appointment = Appointment.find(params[:id])
    binding.pry
    
  end
end
