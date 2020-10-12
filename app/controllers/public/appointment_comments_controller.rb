class Public::AppointmentCommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    target = Appointment.where(to_customer_id: current_customer.id).or(Appointment.where(from_customer_id: current_customer.id))
    @appointment_comments = AppointmentComment.where(appointment_id: target.ids).group(:appointment_id).includes(:appointment)
  end

  def show
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id]).includes(:customer)
    @appointment = Appointment.find(params[:id])
    @appointment_comment = AppointmentComment.new
    @comment = Comment.new
  end

  def create
    appointment_comment = AppointmentComment.new(appointment_comment_params)
    if appointment_comment.save
      flash[:success] = "メッセージを送信しました"
      redirect_to appointment_comment_path(params[:appointment_comment][:appointment_id])
    end
  end
  
  private
  def appointment_comment_params
    params.require(:appointment_comment).permit(:customer_id, :appointment_id, :content)
  end
end
