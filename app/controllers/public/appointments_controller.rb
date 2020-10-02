class Public::AppointmentsController < ApplicationController
  def index
    
  end

  def create
    ActiveRecord::Base.transaction do
      binding.pry
      if params[:request_date_exist] == "1"
        binding.pry
        appointment = Appointment.new(appointment_params)
        appointment.customer_id = params[:customer_id]
        appointment.from_customer_id = current_customer.id
        appointment.service_id = params[:service_id]
        appointment.status = "applying"
        
        binding.pry
        
        appointment.save!
        binding.pry
        @appointment_id = appointment.id
        
        binding.pry
        appointment_comment = AppointmentComment.new(appointment_comment_params)
        appointment_comment.customer_id = current_customer.id
        appointment_comment.appointment_id = @appointment_id
        appointment_comment.content = params[:first_message]
        
        binding.pry
        
        appointment_comment.save!
      else
        appointment = Appointment.new(appointment_params)
        appointment.customer_id = params[:customer_id]
        appointment.from_customer_id = current_customer.id
        appointment.service_id = params[:service_id]
        appointment.status = "applying"
        appointment.request_date = "undecided"
        appointment.save!(appointment_params)
        @appointment_id = appointment.id

        appointment_comment = AppointmentComment.new(appointment_comment_params)
        appointment_comment.customer_id = current_customer.id
        appointment_comment.appointment_id = @appointment_id
        appointment_comment.content = params[:first_message]
        
        binding.pry
        
        appointment_comment.save!(appointment_comment_params)
      end
      redirect_to service_appointments_complete_path
    end
  rescue => e
    puts e
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
