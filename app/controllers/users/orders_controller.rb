class Users::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to users_orders_path
    else
      render :new
    end
  end
  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:description)
  end
end
