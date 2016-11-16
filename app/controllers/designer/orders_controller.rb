class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required
  # before_action :get_current_order, only: [:show]

  def index
    @orders = Order.available_for(current_user)
  end

  def show
    @order = Order.find(params[:id])
    @current_stage = @order.current_stage

    # binding.pry

    case @order.aasm_state
    when "version_selected"
      if @order.stages.last.closed?
        @current_stage = @order.new_stage
      end
    end

    @versions = @current_stage.versions
  
  end

  def update
  end


  def submit_versions

    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage

    minimum_versions_count = @order.aasm_state == "placed" ? 3 : 1

    if @current_stage.versions.count < minimum_versions_count
      redirect_to designer_order_path(@order), alert: "请至少提交3种不同类型的稿件方案供客户选择"
      return
    end

    # 确认当前order没有被别人接过
    if @order.set_designer?(current_user) || @order.designer_id == current_user.id

      # order状态转换的限制 placed -> submitted || selected -> submitted
      # binding.pry
      if @order.may_submit_initial_versions?
        @order.submit_initial_versions!
      elsif @order.may_submit_new_versions?
        @order.submit_new_versions!
      else
        redirect_to designer_order_path(@order), alert: "发生了不应该发生的错误"
        return
      end
      redirect_to designer_order_path(@order), notice: "已向用户提交样本"

    else
      redirect_to designer_order_path(@order), alert: "该订单已有人接，请返回订单页选择其他订单"
      return
    end
      
    
  end


  private

  # def get_current_order
  #   @order = Order.find(params[:id])
  #   @current_stage = @order.current_stage
  # end


end
