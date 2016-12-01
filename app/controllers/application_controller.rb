class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  # designer -> user
  $ORDER_PICKED        = "order_picked"
  $DRAFTS_SUBMITTED    = "drafts_submitted"
  $VERSION_SUBMITTED   = "version_submitted"
  $ATTACHMENT_UPLOADED = "attachment_uploaded"


  # user -> designer
  $DRAFT_SELECTED      = "draft_selected"
  $VERSION_SELECTED    = "version_selected"
  $ORDER_COMPLETED     = "order_completed"



  def designer_required
    if !current_user.qualified_designer?
      redirect_to "/", notice: "您没有此权限"
    end
  end


  # 清除当前designer某个order的某个特定状态的notifications
  def clear_unread_notifications_for_order(order, notification_type)
    notifications = Notification.where(receiver_id: current_user.id)
                                .where(order_id: order.id)
                                .where(aasm_state: "unread")
                                .where(notification_type: notification_type)

    notifications.each do |notification|
      notification.check!
    end
  end

  # 清除当前user的所有未读通知
  def clear_current_notifications(order)
    notifications = order.unread_notifications_for_user(current_user)
    notifications.each do |notification|
      notification.check!
    end
  end

  def send_message_to_resource(from, to, resource, subject, body)
  	if body.present?
  		if resource.conversation.blank?
  			from.send_message(to, body, subject, resource)
  		else
  			from.reply_to_conversation(resource.conversation, body)
  		end
  	end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end
end
