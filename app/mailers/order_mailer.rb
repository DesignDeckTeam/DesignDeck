class OrderMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new_record_notification.subject
  #
  
  def notify_order_state(order, current_user)
    @order = order
    receiver = current_user.is_user? ? order.designer : order.user
    subject = ""
    case order.aasm_state
    when "picked"
      subject = "[DesignDeck] 您好，您的订单:#{order.title},设计师已接单 "
    when "drafts_submitted"
      subject = "[DesignDeck] 您好，您的订单:#{order.title},设计师已提交初稿 #{order.title}"
    when "versions_submitted"
      subject = "[DesignDeck] 您好，您的订单:#{order.title},设计师已提交新稿件 #{order.title}"
    when "completed"
      if current_user.is_user?
        subject = "[DesignDeck] 您好，您的订单:#{order.title},最终版本文件打包已上传 #{order.title}"
      else
        subject = "[DesignDeck] 您好，您接的订单:#{order.title},用户已确认最终版，请上传打包文件 #{order.title}"
      end
    when "draft_selected"
      subject = "[DesignDeck] 您好，您接的订单:#{order.title},用户已选择初稿 #{order.title}"
    when "version_selected"
      subject = "[DesignDeck] 您好，您接的订单:#{order.title},用户已对稿件提出修改意见 #{order.title}"
    end
    mail(to: receiver.email, subject: subject)
  end

end
