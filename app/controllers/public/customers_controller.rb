class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @services = @customer.services.includes(:customer)
    @comments = Comment.joins(service: :customer).where(customers: {id: @customer.id})
  end

  def show
    
    binding.pry
    if current_customer.id == params[:id]
      redirect_to mypage_path
    else
      
    end
    
  end

  def edit
    @customer = current_customer
  end

  def update
    if current_customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
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
end
