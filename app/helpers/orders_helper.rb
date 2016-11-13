module OrdersHelper
  def render_order_step(_order)
    case @order.aasm_state
    when "order_placed"
      render "common/initial_version"
    when "sample_submitted"
      render "waiting_for_customer_decision"
    when "style_decided"
      render "common/second_version"
    when "started"
      render "more_version"
     end
  end
end
