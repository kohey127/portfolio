class Public::CustomersController < ApplicationController
  def index
  end

  def show
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
  end
  
  private
  def customer_params
    params.require(:customer).permit(:image, :name, :introduction, :based)
  end
end
