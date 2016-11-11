class Users::OrdersController < ApplicationController

  before_action :authenticate_user!



  def index
    @orders = current_user.orders
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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to users_orders_path
    else
      render :new
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to users_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:title, :description, :type)
  end
end
