class Public::CommentsController < ApplicationController
  def create
    appointment = Appointment.find(params[:id])
    from_customer = Customer.find(appointment.from_customer_id)
    to_customer = Customer.find(appointment.to_customer_id)
    point = appointment.service.point
    
    binding.pry
    
    # ポイント処理
    to_cusotmer.exp_point += point
    from_customer.point -= point
    # コメントの書き込み
    comment = Comment.new(comment_params)
    comment.save
    # 予約ステータスを取引完了に更新
    appointment.done!
    if comment.save
      flash[:notice] = "コメントを書き込みました。"
    end    
  end
  
  private
  def comment_params
    params.require(:comment).permit(:cusotmer_id, :service_id, :content)
  end
end
