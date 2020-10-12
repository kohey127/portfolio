class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @services = @customer.services.includes(:customer)
    @comments = get_comments(@customer.id)
  end

  def show    
    @customer = Customer.find(params[:id])
    # 自分のユーザ、もしくは管理者ユーザ詳細ページを見るときはマイページにリダイレクト
    if @customer == current_customer || params[:id] == "1"
      redirect_to mypage_path
    else
      @services = @customer.services.includes(:customer)
      @comments = get_comments(@customer.id)
    end    
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "プロフィールの更新が完了しました。"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.services.update_all(is_active: false)
    if current_customer.update(is_active: false)
      reset_session
      flash[:success] = "退会処理が完了しました。ご利用ありがとうございました。"
    end
    redirect_to root_path
  end
  
  private
  def customer_params
    params.require(:customer).permit(:image, :name, :introduction, :based)
  end

  # 顧客が受けたレビューを取得
  def get_comments(id)
    Comment.joins(service: :customer).where(customers: {id: id})
  end
end
