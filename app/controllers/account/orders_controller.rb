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
    @current_stage = @order.current_stage
  end

  def edit
    @order = Order.find(params[:id])
  end

  def select_version
    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage
    version = Version.find_by(id: select_version_params[:version_id])
    version.select!
    @order.select_version!

    binding.pry
    if select_version_params[:comment].present?
      comment = @current_stage.stage_comments.build
      comment.content = select_version_params[:comment]
      comment.user = current_user
      comment.save
      # comment.set_comment(select_version_params[:comment])
    end

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

  def select_version_params
    params.require(:order).permit(:version_id, :comment)
  end


end
