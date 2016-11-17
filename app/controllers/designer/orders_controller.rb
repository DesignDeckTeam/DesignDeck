class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required

  # 不能让其他designer查看到不属于自己的order
  # before_action :allow_legal_designers

  def index
    @orders = Order.available_for(current_user)
  end

  def show
    @order = Order.find(params[:id])

    # binding.pry

    case @order.aasm_state
    when "version_selected"
      if @order.stages.last.closed?
        @current_stage = @order.new_stage
      end
    end

    @versions = @order.current_stage.versions
  
  end

  def update
  end


  # order必须是在paid的状态下
  def pick_order
    @order = Order.find(params[:order_id])
    # 确认当前order没有被别人接过
    if @order.set_designer?(current_user)
      # 产生一个新的stage
      @current_stage = @order.current_stage
      redirect_to designer_order_path(@order), notice: "获得了这个订单"
    else
      redirect_to designer_orders_path, alert: "抢单失败"
    end
  end


  # picked / selected -> submitted
  def submit_versions

    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage
    comment = comment_param[:comment]

    # binding.pry

    minimum_versions_count = @order.aasm_state == "picked" ? 1 : 1

    if @current_stage.versions.count < minimum_versions_count
      redirect_to designer_order_path(@order), alert: "请至少提交3种不同类型的稿件方案供客户选择"
      return
    end
      # binding.pry
    if @order.may_submit_initial_versions?
      @order.submit_initial_versions!
    elsif @order.may_submit_new_versions?
      @order.submit_new_versions!
    else
      redirect_to designer_order_path(@order), alert: "发生了不应该发生的错误"
      return
    end

    # 添加评论
    # binding.pry
    if @current_stage.conversation.blank?
      current_user.send_message(@order.user, comment, "stage#{@current_stage.id} conversation", @current_stage)
    else
      current_user.reply_to_conversation(@current_stage.conversation, comment)
    end

    redirect_to designer_order_path(@order), notice: "已向用户提交样本"     
    
  end


  private

  def allow_legal_designers
    @order = Order.find(params[:id])
    # if @order.designer_id != current_user.id

  end

  def comment_param
    params.require(:order).permit(:comment)
  end


end
