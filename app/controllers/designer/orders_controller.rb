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

private

  def order_params
    params.require(:order).permit(:image1_from_designer, :image2_from_designer, :image3_from_designer)
  end

  # designer uploaders three images style to user.
  def three_image_versions

   if params[:order].present?

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



      if @order.versions.first.present?
        version2 = @order.versions.first
        version2.for_status = "example"
        version2.save
      end

      if @order.versions.second.present?
        version2 = @order.versions.second
        version2.for_status = "example"
        version2.save
      end

      if @order.versions.third.present?
        version2 = @order.versions.third
        version2.for_status = "example"
        version2.save
      end

   else
      flash[:warm] = "不能上传空照片!"
   end
  end
end
