class Notification < ApplicationRecord
  include AASM

  aasm do
  end

  include AASM
  aasm do
	state :unread, :initial => true
   	state :read

   	event :check do
  		transitions :from => :unread, :to => :read
   	end
   	
  end

	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "User"
	belongs_to :order

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
