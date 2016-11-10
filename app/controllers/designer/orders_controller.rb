class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])

  end

end
