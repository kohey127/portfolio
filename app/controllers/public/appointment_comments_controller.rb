class Public::AppointmentCommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    target = Appointment.where(to_customer_id: current_customer.id).or(Appointment.where(from_customer_id: current_customer.id))
    @appointment_comments = AppointmentComment.where(appointment_id: target.ids).group(:appointment_id).includes(:appointment)
  end

  def show
    @appointment = Appointment.find(params[:id])
    # 自分以外のチャットルームの参照を禁止する
    unless @appointment.from_customer_id == current_customer.id || @appointment.to_customer_id == current_customer.id
      flash[:danger] = "このページにはアクセスできません"
      redirect_to appointments_path
    end
    @appointment_comments = AppointmentComment.where(appointment_id: params[:id]).includes(:customer)
    # 通知の既読
    if @appointment.has_unchecked_notification(current_customer)

    end

    @appointment_comment = AppointmentComment.new
    @comment = Comment.new
  end

  def create
    @appointment_comment = AppointmentComment.new(appointment_comment_params)
    if @appointment_comment.save
      # 新規通知作成
      @appointment_comment.create_notification_chat!(current_customer, @appointment_comment.id)

      flash[:success] = "メッセージを送信しました"
      redirect_to appointment_comment_path(params[:appointment_comment][:appointment_id])
    end
  end
  
  private
  def appointment_comment_params
    params.require(:appointment_comment).permit(:customer_id, :appointment_id, :content)
  end
end
