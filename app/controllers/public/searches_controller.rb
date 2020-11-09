class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    
    case @range
    when '1'
      @services = Service.search(@word)
    when '2'
      @customers = Customer.search(@word)
    end
  end
  
end
