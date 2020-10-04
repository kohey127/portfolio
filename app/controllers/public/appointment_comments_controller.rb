class Public::AppointmentCommentsController < ApplicationController
  def index
    target = Appointment.where(to_customer_id: current_customer.id).or(Appointment.where(from_customer_id: current_customer.id))
    @appointment_comments = AppointmentComment.where(appointment_id: target.ids).group(:appointment_id)

  end

  def show
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id])
    @appointment = Appointment.find(params[:id])
    @appointment_comment = AppointmentComment.new
    @comment = Comment.new
  end

  def create
    
    binding.pry
    
    appointment_comment = AppointmentComment.new(appointment_comment_params)
    if appointment_comment.save
      redirect_to appointment_comment_path(params[:appointment_comment][:appointment_id])
    end
  end
  
  private
  def appointment_comment_params
    params.require(:appointment_comment).permit(:customer_id, :appointment_id, :content)
  end
end
