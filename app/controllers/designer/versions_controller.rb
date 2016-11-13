class Designer::VersionsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @version = @order.versions.build
    @version.samples.build
  end

  def create
    @order = Order.find(params[:order_id])
    @version = @order.versions.build(version_params)

    puts version_params

    if @version.save
      redirect_to designer_order_version_path(@order, @version), notice: "成功创建了样张"
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:order_id])
    @version = Version.find(params[:id])
    @samples = @version.samples
  end

  private

  def version_params
    params.require(:version).permit(samples_attributes: %i(id image _destroy user_id))
  end
end
