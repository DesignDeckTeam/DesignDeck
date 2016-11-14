class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @current_stage = Stage.find_by(id: @order.current_stage_id)
    if @current_stage.blank?
      @current_stage = @order.stages.build
      @current_stage.save
      @order.current_stage_id = @current_stage.id
      @order.save
    end
   
    @versions = @current_stage.versions
  end

  def update
  end


  def designer_submit_sample
    @order = Order.find(params[:order_id])

    if @order.versions.count < 3
      redirect_to designer_order_path(@order), alert: "请至少提交3种不同类型的稿件方案供客户选择"
      return
    end

    if @order.may_submit_sample?
      @order.submit_sample!
      redirect_to designer_order_path(@order), notice: "已向用户提交样本"
    else
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR"
    end
    
  end


end
