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
      if _user.designer?
        render "common/designer_order_completed"
      else
        render "common/user_order_completed"
      end
    end
  end

  def render_additional_comment_if_necessary(order)
    if current_user.is_user? && order.version_selected?
      render partial: "common/add_comment", locals: { path: account_order_submit_additional_comment_path(order), button_text: "补充评论" }
    elsif current_user.designer? && order.versions_submitted?
      render partial: "common/add_comment", locals: { path: designer_order_submit_additional_comment_path(order), button_text: "补充评论" }
    end
  end


  def std_time(time)
    time.strftime("%Y年%m月%d日 %H:%M")
  end








end
