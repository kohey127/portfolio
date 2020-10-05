class Public::CommentsController < ApplicationController
  def create
    # ポイント更新事前準備
    appointment = Appointment.find(params[:comment][:appointment_id])
    from_customer = Customer.find(appointment.from_customer_id)
    to_customer = Customer.find(appointment.to_customer_id)
    point = appointment.service.point
    point_history = PointHistory.new
    exp_history = ExpHistory.new
    if from_customer.point_histories.blank?
      latest_point = from_customer.point
    else
      latest_point = from_customer.point_histories.balance.order(created_at: :desc).limit(1)
    end
    if to_customer.exp_histories.blank?
      latest_exp = 0
    else
      latest_exp_histories = to_customer.exp_histories.order(created_at: :desc).limit(1)
      latest_exp = latest_exp_histories.balance
    end

    # ポイント更新処理
    from_customer.update(point: from_customer.point -= point)
    to_customer.update(exp_point: to_customer.exp_point += point)
    
    # ポイント履歴更新処理
    point_history.customer_id = from_customer.id
    point_history.balance = latest_point - point
    point_history.trigger = appointment.id
    point_history.save    
    exp_history.customer_id = to_customer.id
    exp_history.balance = latest_exp + point
    exp_history.trigger = appointment.id
    exp_history.save
    
    # コメントの書き込み
    comment = Comment.new(comment_params)
    comment.save
    
    # 予約ステータスを取引完了に更新
    appointment.done!
    
    redirect_to appointments_path
  end
  
  private
  def customer_params
    params.require(:customer).permit(:exp_point, :point)
  end

  def comment_params
    params.require(:comment).permit(:customer_id, :service_id, :content)
  end

  def point_histories_params
    params.require(:point_history).permit(:customer_id, :balance, :trigger)
  end

  def exp_histories_params
    params.require(:exp_history).permit(:customer_id, :balance, :trigger)
  end
end
