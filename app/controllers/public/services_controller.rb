class Public::ServicesController < ApplicationController
  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      flash[:notice] = "体験を登録しました"
    else
      render :new
    end
  end

  private
end
