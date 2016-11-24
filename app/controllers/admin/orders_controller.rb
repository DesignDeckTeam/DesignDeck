class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def index
     @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy

    redirect_to admin_orders_path
  end

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

end
