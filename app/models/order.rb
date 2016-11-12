# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :text
#  type_preference :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  aasm_state      :string
#  user_id         :integer
#  sample_number   :integer
#

class Order < ApplicationRecord

validates :image_from_designer, presence: true

	has_many :versions
	belongs_to :user
  accepts_nested_attributes_for :versions

  include AASM



  aasm do
  	state :order_placed, :initial => true
  	state :sample_submitted
  	state :style_decided
  	state :started
  	state :completed

  	event :submit_sample do
      transitions :from => :order_placed, :to => :sample_submitted
    end

    event :decide_style do
      transitions :from => :sample_submitted, :to => :style_decided
    end

    event :start do
      transitions :from => :style_decided, :to => :started
    end

    event :complete do
      transitions :from => :started, :to => :completed
    end

  end
end
