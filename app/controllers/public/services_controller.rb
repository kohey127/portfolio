class Public::ServicesController < ApplicationController
  before_action :authenticate_customer!
  
  def top
    @services = Service.where.not(customer_id: current_customer.id, is_active: false).includes(:customer)
  end

  def about

  end

  def show
    @service = Service.find(params[:id])
    @customer = @service.customer
    @comments = @service.comments.includes(:customer)
  end
  
  def new
    @service = Service.new
  end

  def update
    service = Service.find(params[:id])
    case params[:service]
    when "open"
      service.update(is_active: true)
    when "close"
      service.update(is_active: false)
    end
    redirect_to mypage_path
  end

  def create
    @service = Service.new(service_params)
    @service.customer_id = current_customer.id
    if @service.save(service_params)
      flash[:notice] = "体験を登録しました"
      redirect_to mypage_path
    else
      render :new
    end
  end

  private
  def service_params
    params.require(:service).permit(:customer_id, :content, :place, :catchphrase, :image, :point, :is_active, :format)
  end
end
