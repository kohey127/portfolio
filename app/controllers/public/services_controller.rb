class Public::ServicesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]

  def top
      # 公開中の全体験を取得
      @services = Service.where(is_active: true).includes(:customer)
      # 管理者ユーザ(id=1)を除いた有効会員を獲得EXP順に並び替えて取得
      @customers = Customer.where.not(id: 1, is_active: false).order(exp_point: "desc").includes(services: :comments)
  end

  def index
    ids = current_customer.favorites.pluck(:service_id)
    @services = Service.where(id: ids)
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
    if @service.customer != current_customer
      flash[:danger] = "このページへはアクセスできません"
      redirect_to mypage_path
    end
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      flash[:success] = "体験の情報を更新しました"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def status_update
    service = Service.find(params[:service_id])
    case params[:status]
    when "open"
      service.update(is_active: true)
      flash[:success] = "体験の公開を再開しました"
    when "close"
      if current_customer.have_been_applied.where(service_id: service.id).present?
        flash[:danger] = "この体験は提供中のため非公開にできません。"
        redirect_to mypage_path and return
      end
      service.update(is_active: false)
      flash[:success] = "体験をの公開を停止しました"
    end
    redirect_to mypage_path
  end

  def create
    @service = Service.new(service_params)
    @service.customer_id = current_customer.id
    if @service.save(service_params)
      flash[:success] = "体験を登録しました"
      redirect_to mypage_path
    else
      render :new
    end
  end

  def destroy
    service = Service.find(params[:id])
    if current_customer.have_been_applied.where(service_id: service.id).present?
      flash[:danger] = "この体験は提供中のため削除できません。"
      redirect_to mypage_path and return
    end    
    if service.destroy
      flash[:success] = "体験を削除しました"
    end
    redirect_to mypage_path
  end

  private
  def service_params
    params.require(:service).permit(:customer_id, :content, :place, :catchphrase, :image, :point, :is_active, :format)
  end
end
