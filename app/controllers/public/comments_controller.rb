class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    # ポイント更新事前準備
    appointment = Appointment.find(params[:comment][:appointment_id])
    from_customer = Customer.find(appointment.from_customer_id)
    to_customer = Customer.find(appointment.to_customer_id)
    point = appointment.service.point
    point_history = PointHistory.new
    exp_history = ExpHistory.new
    latest_point = from_customer.point
    latest_exp = to_customer.exp_point
    
    # レビューの書き込み
    comment = Comment.new(comment_params)
    # レビューの感情分析結果を取得
    comment.score = Language.get_data(comment_params[:content])
    if comment.save
      flash[:success] = "レビューを書いて体験を完了しました。"
    else
      flash[:danger] = "レビューが空です。"
      redirect_to appointment_comment_path(appointment.id) and return
    end
    
    # 予約ステータスを取引完了に更新
    appointment.done!

    # ポイント更新処理
    from_customer.update(point: from_customer.point -= point)
    to_customer.update(exp_point: to_customer.exp_point += point)

    # ポイント履歴更新処理(customer_idには自身のID、triggerには相手のIDを格納)
    point_history.customer_id = from_customer.id
    point_history.balance = latest_point - point
    point_history.trigger_id = to_customer.id
    point_history.save
    exp_history.customer_id = to_customer.id
    exp_history.balance = latest_exp + point
    exp_history.trigger_id = from_customer.id
    exp_history.save
    
    redirect_to appointments_path
  end
  
  private
  def comment_params
    params.require(:comment).permit(:customer_id, :service_id, :content)
  end
end
