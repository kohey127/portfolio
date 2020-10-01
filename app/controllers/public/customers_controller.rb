class Public::CustomersController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @genres = Genre.all
  end

  def update
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
