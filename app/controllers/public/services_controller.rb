class Public::ServicesController < ApplicationController
  before_action :authenticate_customer!

  def top
    # 自分の以外、かつ公開中のサービスを取得
    @services = Service.where.not(customer_id: current_customer.id, is_active: false).includes(:customer)
    # 獲得EXP順に並び替えた顧客情報を取得
    @customers = Customer.all.order(exp_point: "desc")
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

  def edit
    @service = Service.find(params[:id])
  end

  def update
    service = Service.find(params[:id])
    if service.update(service_params)
      flash[:notice] = "体験の情報を更新しました"
    else
      render :edit
    end
    redirect_to mypage_path
  end

  def status_update
    service = Service.find(params[:service_id])
    case params[:status]
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
