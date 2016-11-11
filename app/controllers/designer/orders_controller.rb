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

    if order_params[:image1_from_designer].present? 
      if @order.versions.first.blank?
        version1 = @order.versions.build
      else
        version1 = @order.versions.first
      end
      version1.image_from_designer = order_params[:image1_from_designer]
      version1.save
    end

    if order_params[:image2_from_designer].present? 
      if @order.versions.second.blank?
        version2 = @order.versions.build
      else
        version2 = @order.versions.second
      end
      version2.image_from_designer = order_params[:image2_from_designer]
      version2.save
    end

    if order_params[:image3_from_designer].present? 
      if @order.versions.third.blank?
        version3 = @order.versions.build
      else
        version3 = @order.versions.third
      end
      version3.image_from_designer = order_params[:image3_from_designer]
      version3.save
    end    

    redirect_to designer_order_path, notice: "Update Success"

  end

private

  def order_params
    # params.require(:order).permit(versions_attributes:[:image_from_designer], versions_attributes:[:image_from_customer])
    params.require(:order).permit(:image1_from_designer, :image2_from_designer, :image3_from_designer)

  end
end
