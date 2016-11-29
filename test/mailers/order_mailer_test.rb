require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "new_record_notification" do
    mail = OrderMailer.new_record_notification
    assert_equal "New record notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
