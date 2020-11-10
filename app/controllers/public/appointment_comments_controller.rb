class Public::AppointmentCommentsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @appointment = Appointment.find(params[:id])
    # 自分以外のチャットルームの参照を禁止する
    unless @appointment.from_customer_id == current_customer.id || @appointment.to_customer_id == current_customer.id
      flash[:danger] = "このページにはアクセスできません"
      redirect_to appointments_path
    end
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id]).includes(:customer)
    @appointment_comment = AppointmentComment.new
    @comment = Comment.new
  end

  def create
    @appointment_comment = AppointmentComment.new(appointment_comment_params)
    if @appointment_comment.save
      flash[:success] = "メッセージを送信しました"
      redirect_to appointment_comment_path(params[:appointment_comment][:appointment_id])
    else
      @appointment = Appointment.find(params[:appointment_comment][:appointment_id])
      @appointment_comments = AppointmentComment.where(params[:appointment_comment][:appointment_id]).includes(:customer)
      @comment = Comment.new
      render :show
    end
  end
  
  private
  def appointment_comment_params
    params.require(:appointment_comment).permit(:customer_id, :appointment_id, :content)
  end
end
