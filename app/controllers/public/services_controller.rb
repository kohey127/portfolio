class Public::ServicesController < ApplicationController
  def top

  end

  def about

  end
  
  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.customer_id = current_customer.id
    
    binding.pry
    
    if @service.save(service_params)
      flash[:notice] = "体験を登録しました"
    else
      render :new
    end
  end

  private
  def service_params
    params.require(:service).permit(:customer_id, :content, :place, :catchphrase, :image, :point, :is_active, :format)
  end
end
