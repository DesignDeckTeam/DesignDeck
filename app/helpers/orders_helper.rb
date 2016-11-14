module OrdersHelper
  def render_order_step(_order)
    case @order.aasm_state
    when "order_placed"
      render "user_requirement"
    when "sample_submitted"
      render "waiting_for_customer_decision"
    when "style_decided"
      render "designer_upload_image_to_user"
    when "started"
      render "completed_design"
     end
  end
end
