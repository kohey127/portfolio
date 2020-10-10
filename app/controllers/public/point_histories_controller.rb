class Public::PointHistoriesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @exp_histories = current_customer.exp_histories
    @point_histories = current_customer.point_histories
  end

end
