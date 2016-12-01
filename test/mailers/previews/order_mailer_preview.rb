# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/new_record_notification
  def new_record_notification
    OrderMailer.new_record_notification
  end

  def notify_order_picked
    OrderMailer.notify_order_picked(Order.fourth)


  end

end
