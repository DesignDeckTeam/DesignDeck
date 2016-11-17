class Stage < ApplicationRecord

  has_one :conversation, as: :conversationable

  include AASM

  aasm do
  	state :open, initial: true
  	state :closed

  	event :close do
  		transitions :from => :open, :to => :closed
  	end
  	
  end
	belongs_to :order
	has_many :stage_comments
	has_many :versions




end

# == Schema Information
#
# Table name: stages
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  aasm_state :string
#
