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


    when "drafts_submitted"
      if _user.designer?
        render "common/designer_submitted_drafts"
      else
        render "common/user_drafts_submitted"
      end

    when "draft_selected"
      if _user.designer?
        render "common/designer_draft_selected"
      else
        render "common/user_draft_selected"
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

  def render_download_order_attachment_button(order)
    if order.attachment.present? 
      link_to("下载最终版", order.attachment_url, download: "", class: "btn btn-warning with-button history-button")
    else 
      link_to("下载最终版", "#", download: "", class: "btn btn-default with-button history-button", disabled: "disabled")
    end
  end

  def render_lastest_stage_snap_button(stage, order, user)
    if stage == order.last_versioned_stage 
      if user.is_user?
        link_to "最新稿", account_order_path(order, stage_id: order.last_versioned_stage.id), class: "btn btn-primary history-button", style: "margin-left:30px;" 
      elsif user.designer?
        link_to "最新稿", designer_order_path(order, stage_id: order.last_versioned_stage.id), class: "btn btn-primary history-button", style: "margin-left:30px;" 
      end
    else 
      if user.is_user?
        link_to "最新稿", account_order_path(order, stage_id: order.last_versioned_stage.id), class: "btn btn-default history-button", style: "margin-left:30px;" 
      elsif user.designer?
        link_to "最新稿", designer_order_path(order, stage_id: order.last_versioned_stage.id), class: "btn btn-default history-button", style: "margin-left:30px;" 
      end
    end 
  end

  def render_another_stage_snap_button(stage, another_stage, order, user, index)
    if stage == another_stage 
      if user.is_user?
        link_to "第#{@other_stages.count - index}稿", account_order_path(order, stage_id: another_stage.id), class: "btn btn-primary history-button"
      elsif user.designer?
        link_to "第#{@other_stages.count - index}稿", designer_order_path(order, stage_id: another_stage.id), class: "btn btn-primary history-button"
      end          
    else
      if user.is_user?
        link_to "第#{@other_stages.count - index}稿", account_order_path(order, stage_id: another_stage.id), class: "btn btn-default history-button"
      elsif user.designer?
        link_to "第#{@other_stages.count - index}稿", designer_order_path(order, stage_id: another_stage.id), class: "btn btn-primary history-button"  
      end
    end
  end


  def std_time(time)
    time.strftime("%Y年%m月%d日 %H:%M")
  end
  
end
