class Public::AppointmentsController < ApplicationController
  def index
    
  end

  def create
    
    binding.pry
    if params[:request_date_exist] == 0
      
    elsif request_date_exist == 1
    
    end
  end

  def new
    @appointment = Appointment.new
    @service = Service.find(params[:service_id])
  end

  private
  def appointment_params
    params.require(:appointment).permit(:customer_id, :content, :place, :catchphrase, :image, :point, :is_active, :format)
  end
end
