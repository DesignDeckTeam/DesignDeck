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
    # binding.pry

    @order = Order.find(params[:id])
    @stage = @order.current_stage
    case @order.aasm_state
    when "versions_submitted"
      @stage = @order.stages.last
    else
      @stage = @order.stages.closed.last
    end
    # @current_stage = @order.current_stage
  end

  def edit
    @order = Order.find(params[:id])
  end

  # 用户选择了一个version，并且给出了理由
  # 一定是在submitted的状态下运行
  def select_version

    binding.pry

    @order = Order.find(params[:order_id])
    @stage = @order.stages.last
    @stage.close!
    version = Version.find_by(id: select_version_params[:version_id])
    version.select!
    @order.select_version!

    # binding.pry
    if select_version_params[:comment].present?
      comment = @stage.stage_comments.build
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
    params.require(:order).permit(:title, :description, :preference_type, :comment_from_customer)
  end

  def select_version_params
    params.require(:order).permit(:version_id, :comment)
  end


end
