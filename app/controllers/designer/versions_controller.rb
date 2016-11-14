class Designer::VersionsController < ApplicationController


  before_action :get_order_and_current_stage

  def new
    @version = @current_stage.versions.build
    @version.samples.build
  end

  def create
    @version = @current_stage.versions.build(version_params)

    if @version.save && @version.samples.count > 0
      @version.submit!
      redirect_to designer_order_path(@order), notice: "成功创建了样张"      
    else
      @version.destroy
      redirect_to new_designer_order_stage_version_path(@order, @current_stage), alert: "不能提交空图片"
    end

  end

  def show
    @version = Version.find(params[:id])
    @samples = @version.samples
  end

  private

  def version_params
    params.require(:version).permit(samples_attributes: %i(id image _destroy user_id))
  end

  def get_order_and_current_stage
    @order = Order.find(params[:order_id])
    @current_stage = @order.current_stage
  end

end
