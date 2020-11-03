class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @service = Service.find(params[:service_id])
    favorite = current_customer.favorites.new(service_id: @service.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @service = Service.find(params[:service_id])
    favorite = current_customer.favorites.find_by(service_id: @service.id)
    favorite.destroy
    redirect_to request.referer
  end
end