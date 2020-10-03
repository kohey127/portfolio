class Public::AppointmentCommentsController < ApplicationController
  def index
    @appointments = Appointment.where("to_customer_id OR from_customer_id", current_customer.id, current_customer.id).includes(:appoinment_comment)
  end
end
