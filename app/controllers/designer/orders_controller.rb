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
    @version = @order.versions.update(order_params)
      redirect_to designer_order_path, notice: "Update Success"
  end

private

  def order_params
    params.require(:order).permit(versions_attributes:[:image_from_designer], versions_attributes:[:image_from_customer])
  end
end
