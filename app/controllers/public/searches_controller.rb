class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]
    
    if @range == '1'
      @services = Service.search(search, @word)
    else
      @customers = Customer.search(search, @word)
    end
  end
  
end
