class Account::OrdersController < ApplicationController
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
      redirect_to account_orders_path
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

  def choose_style
    @order = Order.find(params[:order_id])
    version = Version.find_by(id: style_choose_params[:version_id])
    version.decide_style!
    @order.decide_style!
    version.set_comment_from_customer(style_choose_params[:comment])
    redirect_to account_order_path(@order), notice: "已选择方案"
  end


  def update
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to account_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:title, :description, :preference_type, :sample_number, :comment_from_customer)
  end

  def style_choose_params
    params.require(:order).permit(:version_id, :comment)
  end

end
