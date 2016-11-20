class ConversationsController < ApplicationController

  def index
  	@order = Order.find(params[:order_id])
  	@stages = @order.stages
  end

  def show

  end

end
