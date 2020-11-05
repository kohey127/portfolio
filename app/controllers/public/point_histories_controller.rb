class Public::PointHistoriesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @exp_histories = current_customer.exp_histories
    @point_histories = current_customer.point_histories
  end

  # ポイント一括更新アクション
  def update
    # 管理者以外のアクセスを拒否する
    if current_customer.id != 1
      flash[:danger] = '不正なアクセスです'
      redirect_to root_path and return
    end

    # 加算するポイントと管理者以外のポイント加算対象Shexperをそれぞれ変数に定義
    point = params[:quantity]
    target_customers = Customer.where.not(id: 1)

    # 全Shexperのポイント履歴の更新
    PointHistory.import target_customers.map { |c|
      PointHistory.new(customer_id: c.id, balance: c.point += point.to_i, trigger_id: 1)
    }

    # 全Shexperのポイント更新
    if target_customers.update_all("point = point + #{point}")
      flash[:success] = '全Shexperのポイントを更新しました。'
    else
      flash[:danger] = 'ポイントの更新に失敗しました。'
    end
    redirect_to mypage_path
    
  end

end