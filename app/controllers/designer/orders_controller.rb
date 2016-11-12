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

    case @order.aasm_state
    when "order_placed"

      if params[:order].present?
        three_image_versions
      else
        redirect_to designer_order_path(@order), alert: "请为客户提交3张不同风格的预选方案"
        return
      end
      
      if @order.has_valid_three_examples?
        @order.submit_sample!
        redirect_to designer_order_path(@order), notice: "成功提交3张图片"        
      else
        redirect_to designer_order_path(@order), notice: "提交图片的数量应为3张"
      end    

    end

  end





private


  # designer uploaders three images style to user.
  def three_image_versions

    if order_params[:image1_from_designer].present?
      if @order.versions.first.blank?
        version1 = @order.versions.build
      else
        version1 = @order.versions.first
      end
      version1.save
      version1.set_image_from_designer(order_params[:image1_from_designer])
      version1.set_status!("EXAMPLE")
    end

    if order_params[:image2_from_designer].present?
      if @order.versions.second.blank?
        version2 = @order.versions.build
      else
        version2 = @order.versions.second
      end
      version2.save
      version2.set_image_from_designer(order_params[:image2_from_designer])
      version2.set_status!("EXAMPLE")
    end

    if order_params[:image3_from_designer].present?
      if @order.versions.third.blank?
        version3 = @order.versions.build
      else
        version3 = @order.versions.third
      end
      version3.save
      version3.set_image_from_designer(order_params[:image3_from_designer])
      version3.set_status!("EXAMPLE")
    end

  end

  def order_params
    params.require(:order).permit(:image1_from_designer, :image2_from_designer, :image3_from_designer)
  end


end
