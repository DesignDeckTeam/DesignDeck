# == Schema Information
#
# Table name: versions
#
#  id                    :integer          not null, primary key
#  stage_id              :integer
#  image_from_designer   :string
#  image_from_customer   :string
#  for_status            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  comment_from_customer :text
#  comment_from_designer :text
#  aasm_state            :string
#

class Version < ApplicationRecord
  belongs_to :stage

  has_many :samples

  accepts_nested_attributes_for :samples, :allow_destroy => true

  # scope :samples_for_order, -> (order) { where(order_id: order.id).where(aasm_state: "sample_submitted") }
  # scope :decided_samples_for_order, -> (order) { where(order_id: order.id).where(aasm_state: "style_decided") }

  def set_comment_from_customer(comment)
    self.update_columns(comment_from_customer: comment)
  end


  include AASM

  aasm do
    state :draft, initial: true
    state :submitted
    state :selected

   	event :submit_sample do
      transitions :from => :draft, :to => :submitted
    end

    event :decide_style do
      transitions :from => :submitted, :to => :selected
    end

  end


end

