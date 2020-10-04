class Public::AppointmentCommentsController < ApplicationController
  def index
    
    binding.pry
    
    @appointment_comments = AppointmentComment.joins(:appointment)
                                              .where("appointments.to_customer_id OR appointments.from_customer_id", current_customer.id, current_customer.id)
                                              .includes(:appointment, appointment: [:from_customer, :to_customer])
  end

  def show
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id])
    @appointment = Appointment.find(params[:id])
  end
end
