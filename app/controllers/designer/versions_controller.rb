class Designer::VersionsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @version = @order.versions.build
  end

  def create
    @order = Order.find(params[:order_id])
    @version = @order.versions.build(version_params)

    if @version.save
      redirect_to designer_order_path(@order)
    else
      render :new
    end
  end

  def create_samples
    # curiurent_order = Order.find_by(id: params[:order_id])
    # version_one = current_order.versions.build
    # version_two = current_order.versions.build
    # version_three = current_order.versions.build
  end

  def version_params
    params.require(:version).permit(sample_attributes: [:image])
  end
end
