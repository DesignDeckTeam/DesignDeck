class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  layout "order_nav", only: :show

  def pay_with_alipay
    @order = Order.find(params[:order_id])
    @order.pay!

    redirect_to account_orders_path, notice: "使用支付宝成功完成付款"
  end

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    design_total_price

    if @order.save
      redirect_to account_order_path(@order)
    else
      render :new
    end
  end


  def submit_additional_comment
    @order = Order.find(params[:order_id])
    @stage = @order.stages.last
    send_message_to_resource(current_user,@order.designer,
    @stage,"stage#{@stage.id} conversation",comment_param[:comment])

    redirect_to account_order_path(@order), notice: "已发送评论"
  end



  def show
    
    # binding.pry
    @order = Order.find(params[:id])

    if @order.current_stage_id.present?
      @stage = @order.current_stage

      if params[:stage_id].present?
        @stage = Stage.find(params[:stage_id])
      else
        @stage = @order.last_versioned_stage
      end

      unless @stage.order == @order 
        redirect_to account_order_path(@order)
      end

      @other_stages = @order.versioned_stages[0...-1].reverse   
         
    end

      
    
  end

  def edit
    @order = Order.find(params[:id])
  end


  def select_draft

    @order = Order.find(params[:order_id])

    unless @order.drafts_submitted?
      redirect_to account_order_path, alert: "当前订单状态不是drafts_submitted"
      return
    end

    # @stage = @order.stages.last
    @stage = @order.last_versioned_stage
    @stage.close!

    version = Version.find_by(id: select_version_params[:version_id])
    version.select!

    # 在当前的stage中加conversation
    send_message_to_resource(current_user,
                             @order.designer, @stage,
                             "stage#{@stage.id} conversation",
                             select_version_params[:comment])

    # 改变order的state
    if params[:commit] == "确定选择方案"
      @order.select_draft!
      redirect_to account_order_path(@order), notice: "已选择方案"
    else
      redirect_to account_order_path(@order), notice: "发生未知错误"
    end

  end




  # 用户选择了一个version，并且给出了理由
  # 一定是在submitted的状态下运行
  def select_version

    # binding.pry

    @order = Order.find(params[:order_id])

    unless @order.versions_submitted?
      redirect_to account_order_path, alert: "当前订单状态不是submitted"
      return
    end

    @stage = @order.last_versioned_stage

    @stage.close!

    version = Version.find_by(id: select_version_params[:version_id])
    version.select!

    # 在当前的stage中加conversation
    send_message_to_resource(current_user,
                             @order.designer, @stage,
                             "stage#{@stage.id} conversation",
                             select_version_params[:comment])

    if params[:commit] == "确认为最终稿"
      @order.complete!
      redirect_to account_order_path(@order), notice: "已完成订单"
    else
      @order.select_version!
      redirect_to account_order_path(@order), notice: "已发送反馈"
    end

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
    params.require(:order).permit(:title, :description, :preference_type, :comment_from_customer, :image, :product_quantity)
  end

  def select_version_params
    params.require(:order).permit(:version_id, :comment)
  end

  def comment_param
    params.require(:order).permit(:comment)
  end

  def design_total_price
    if @order.preference_type == "LOGO商标"
      @order.total_price = @order.product_quantity * 2000
    elsif @order.preference_type == "PPT演示文稿"
      @order.total_price = @order.product_quantity * 500
    else
      @order.total_price = @order.product_quantity * 1000
    end
  end

end
