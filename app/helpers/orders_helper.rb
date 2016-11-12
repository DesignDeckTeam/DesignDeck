module OrdersHelper
  def render_order_step(_order)
    case @order.aasm_state
    when "order_placed"
      render "common/initial_version"
    when "style_decided"
      render "common/second_version"
    when "started"
      render "more_version"
     end
  end
end
