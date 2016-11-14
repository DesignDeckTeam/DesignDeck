class Designer::VersionsController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @current_stage = 
    @version = @order.versions.build
    @version.samples.build
  end

  def create
    @order = Order.find(params[:order_id])
    @version = @order.versions.build(version_params)

    if @version.save && @version.samples.count > 0
      @version.submit_sample!
      redirect_to designer_order_version_path(@order, @version), notice: "成功创建了样张"      
    else
      @version.destroy
      redirect_to new_designer_order_version_path(@order), alert: "不能提交空图片"
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
