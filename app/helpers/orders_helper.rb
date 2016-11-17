module OrdersHelper
  def render_order_step(_order, _user)

    case @order.aasm_state

    when "placed"
      if _user.designer?
        render "common/designer_order_placed"
      else
        render "common/user_order_placed"
      end
    when "paid"
      if _user.designer?
        render "common/designer_order_paid"
      else
        render "common/user_order_paid"
      end
    when "picked"
      if _user.designer?
        render "common/designer_order_picked"
      else
        render "common/user_order_picked"
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

  def all_user_order_aasm_state
    case order.aasm_state
    when "paid"
      已付款
    when "picked"
      已接单
    when "versions_submitted"
      已提交
    when "version_selected"
      已确认
    when "completed"
      已完成
    end

  end
end
