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

  def update
    @order = Order.find(params[:id])

    if @order.sample_submitted?
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
              @order.versions.first.save
            when 2
              @order.versions.second.comment_from_customer = comment_from_customer
              @order.versions.second.save
            when 3
              @order.versions.third.comment_from_customer = comment_from_customer
              @order.versions.third.save
            end
          end
          redirect_to account_order_path(@order), notice: "已选择方案"
          return
        else
          redirect_to account_order_path(@order), notice: "server receives no sample number"
        end
        redirect_to account_orders_path
      else
        render :new
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to account_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:title, :description, :type_preference, :sample_number, :comment_from_customer)
  end
end
