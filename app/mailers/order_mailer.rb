class OrderMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new_record_notification.subject
  #
  def new_record_notification
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def notify_order_picked(order)
    @user = order.user
    @order = order
    mail(to:  @user.email, subject: "[DesignDeck] 您好，您的订单设计师已接单 #{order}")
  end

end
