class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required
  before_action :get_order_and_current_stage, only: [:show, :update]

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

    if @current_stage.versions.count < 3
      redirect_to designer_order_path(@order), alert: "请至少提交3种不同类型的稿件方案供客户选择"
      return
    end

    if @order.may_submit_versions?
      @order.submit_versions!
      redirect_to designer_order_path(@order), notice: "已向用户提交样本"
    else
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR"
    end
    
  end


  private

  def get_order_and_current_stage
    @order = Order.find(params[:id])
    @current_stage = @order.current_stage
  end


end
