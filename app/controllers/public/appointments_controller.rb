class Public::AppointmentsController < ApplicationController
  def index
    
  end

  def new
    @appointment = Appointment.new
    @service = Service.find(params[:id])
  end
end
