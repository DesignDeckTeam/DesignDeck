class Designer::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @versions = @order.versions
  end

  def update
    @order = Order.find(params[:id])

    three_image_versions
    @order.submit_sample!

    redirect_to designer_order_path, notice: "Update Success"
  end


  def designer_submit_sample
    @order = Order.find(params[:order_id])
    if @order.may_submit_sample?
      @order.submit_sample!
      rredirect_to designer_order_path(@order), notice: "已向用户提交样本"
    else
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR"
    end
    
  end


end
