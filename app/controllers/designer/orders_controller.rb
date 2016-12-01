class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required
  before_action :find_order, only: [:show, :update]

  layout "order_nav", only: :show

  # 不能让其他designer查看到不属于自己的order
  # before_action :allow_legal_designers

  def index
    if params["orders"] == "all_orders"
      @orders = Order.available_for(current_user)
    elsif params["orders"] == "on_going_orders"
      @orders = Order.available_for(current_user).where.not(aasm_state: "paid").where.not(aasm_state: "completed")
    elsif params["orders"] == "new_orders"
      @orders = Order.available_for(current_user).where(aasm_state: "paid")
    elsif params["orders"] == "completed"
      @orders = Order.available_for(current_user).where(aasm_state: "completed")
    else
      @orders = Order.available_for(current_user)
    end
    # @current_orders = @orders.where.not(aasm_state: "paid").where.not(aasm_state: "completed")
    # @new_orders = @orders.where(aasm_state: "paid")
    # @completed_orders = @orders.where(aasm_state: "completed")
  end


  # 如果user已经选择了提交的version，designer打开show页面时就生成新的一个stage
  def show

    # 如果是在show页面，就直接清除通知
    clear_current_notifications(@order)

    case @order.aasm_state
    when "version_selected", "draft_selected"
      if @order.stages.last.closed?
        @current_stage = @order.new_stage
      end
    end

    if params[:stage_id].present?
      @stage = Stage.find(params[:stage_id])
    else
      @stage = @order.current_stage
    end

    unless @stage.order == @order
      redirect_to designer_order_path(@order)
    end

    @other_stages = @order.versioned_stages[0...-1].reverse

    @current_versions = @order.current_stage.versions
    @versions = @stage.versions

  end

  def update
    if params[:order].present?
      @order.update(attachment_param)
      # 发送通知
      current_user.send_notification(@order.user, @order, $ATTACHMENT_UPLOADED)
      #OrderMailer.notify_order_state(@order,current_user).deliver!
      redirect_to designer_order_path, notice: "文件已成功提交"
    else
      redirect_to designer_order_path, alert: "需要提交附件"
    end
  end


  def submit_additional_comment
    @order = Order.find(params[:order_id])
    @stage = @order.stages.last
    send_message_to_resource(current_user,
                             @order.user, @stage,
                             "stage#{@stage.id} conversation",
                             comment_param[:comment]) if params[:order].present? && params[:order][:comment].present?

    redirect_to designer_order_path(@order) + "#conversation", notice: "已发送评论"
  end


  # order必须是在paid的状态下
  def pick_order
    @order = Order.find(params[:order_id])
    # 确认当前order没有被别人接过
    if @order.set_designer?(current_user)
      # 产生一个新的stage
      @current_stage = @order.current_stage
      # 发送通知
      current_user.send_notification(@order.user, @order, $ORDER_PICKED)
      #OrderMailer.notify_order_state(@order,current_user).deliver!
      # 刷新
      redirect_to designer_order_path(@order), notice: "获得了这个订单"
    else
      redirect_to designer_orders_path, alert: "抢单失败"
    end
  end


  # picked -> drafts_submitted
  def submit_drafts
    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage

    if @current_stage.versions.count < 3
      redirect_to designer_order_path(@order), alert: "请提交至少3种不同风格的初稿供客户选择"
      return
    end

    if @order.may_submit_drafts?
      @order.submit_drafts!
      # 发送通知
      current_user.send_notification(@order.user, @order, $DRAFTS_SUBMITTED)
      #OrderMailer.notify_order_state(@order,current_user).deliver!
    else
      redirect_to designer_order_path(@order), alert: "发生了不应该发生的错误"
      return
    end

    # 在当前的stage中加conversation

    comment = comment_param[:comment] if params[:order].present? && params[:order][:comment].present?
    send_message_to_resource(current_user, @order.user, @current_stage, "stage#{@current_stage.id} conversation", comment) if params[:order].present? && params[:order][:comment].present?

    redirect_to designer_order_path(@order), notice: "已向用户提交了初稿"

  end



  # draft_selected / version_selected -> submitted
  def submit_versions

    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage

    # binding.pry

    if @current_stage.versions.count < 1
      redirect_to designer_order_path(@order), alert: "请提交新的稿件"
      return
    end

    if @order.may_submit_initial_version?
      @order.submit_initial_version!
    elsif @order.may_submit_new_version?
      @order.submit_new_version!
    else
      redirect_to designer_order_path(@order), alert: "发生了不应该发生的错误"
      return
    end

    # 发送通知
    current_user.send_notification(@order.user, @order, $VERSION_SUBMITTED)
    #OrderMailer.notify_order_state(@order,current_user).deliver!
    # 在当前的stage中加conversation
    comment = comment_param[:comment] if params[:order].present? && params[:order][:comment].present?
    send_message_to_resource(current_user, @order.user, @current_stage, "stage#{@current_stage.id} conversation", comment) if params[:order].present? && params[:order][:comment].present?

    redirect_to designer_order_path(@order), notice: "已向用户提交样本"

  end


  private

  def allow_legal_designers
    @order = Order.find(params[:id])
    # if @order.designer_id != current_user.id

  end

  def find_order
    @order = Order.find(params[:id])
  end

  def comment_param
    params.require(:order).permit(:comment)
  end

  def attachment_param
    params.require(:order).permit(:attachment)
  end


end
