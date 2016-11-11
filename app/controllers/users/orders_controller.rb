class Users::OrdersController < ApplicationController

  before_action :authenticate_user!



  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    3.times { @order.versions.build }
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

      # 如果涉及到用户选择designer提交的3中风格其中的一个
      if @order.sample_number.present?
        @order.decide_style!
        # 如果用户提交了选择的理由
        comment_from_customer = order_params[:comment_from_customer]
        # 将params中的comment存到相应的version中
        if order_params[:comment_from_customer].present?
          case @order.sample_number
          when 1
            @order.versions.first.comment_from_customer = comment_from_customer
          when 2
            @order.versions.second.comment_from_customer = comment_from_customer
          when 3
            @order.versions.third.comment_from_customer = comment_from_customer  
          end
        end
        redirect_to users_order_path(@order), notice: "已选择方案"
        return
      end
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
    params.require(:order).permit(:title, :description, :type_preference, :sample_number, :comment_from_customer)
  end
end
