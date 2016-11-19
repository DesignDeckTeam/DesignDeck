class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def designer_required
    if !current_user.designer?
      redirect_to "/"
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

end
