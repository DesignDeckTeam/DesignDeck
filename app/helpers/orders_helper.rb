module OrdersHelper
  def render_order_step(_order, _user)

    case @order.aasm_state
    when "placed"
      if _user.designer?
        render "common/designer_order_placed"
      else
        render "common/user_order_placed"
      end
    when "versions_submitted"
      if _user.designer?
        render "common/designer_versions_submitted"
      else 
        render "common/user_versions_submitted"
      end
    when "version_selected"
      if _user.designer?
        render "common/designer_version_selected"
      else 
        render "common/user_version_selected"
      end      
    when "completed"
      render "common/completed"
    end    
  end
end
