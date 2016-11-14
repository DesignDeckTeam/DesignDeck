class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required
  before_action :get_current_order, only: [:show]

  def index
    @orders = Order.all
  end

  def show
    @versions = @current_stage.versions
  end

  def update
  end


  def designer_submit_sample

    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage

    minimum_versions_count = @order.aasm_state == "placed" ? 3 : 1

    if @current_stage.versions.count < minimum_versions_count
      redirect_to designer_order_path(@order), alert: "请至少提交3种不同类型的稿件方案供客户选择"
      return
    end

    if @order.may_submit_versions?
      @order.submit_versions!
    elsif @order.may_submit_new_versions?
      @order.submit_new_versions!
    else
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR"
      redirect_to designer_order_path(@order), alert: "发生错误"
      return
    end

    redirect_to designer_order_path(@order), notice: "已向用户提交样本"
    
  end


  private

  def get_current_order
    @order = Order.find(params[:id])
    @current_stage = @order.current_stage
  end


end
