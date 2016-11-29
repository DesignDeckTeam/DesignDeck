require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  notification_type :string
#  link              :string
#  sender_id         :integer
#  receiver_id       :integer
#  order_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  aasm_state        :string
#
