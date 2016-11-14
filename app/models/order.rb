# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  title                :string
#  description          :text
#  preference_type      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  aasm_state           :string
#  user_id              :integer
#  sample_number        :integer
#  current_stage_id     :integer
#  image                :string
#  style_and_regulation :text
#  price                :float
#  deadline             :datetime
#

class Order < ApplicationRecord


	has_many :stages
	belongs_to :user
  accepts_nested_attributes_for :stages, :allow_destroy => true

  # scope :current_stage, -> { Stage.find_by(id: self.current_stage_id) }

  include AASM

  aasm do
  	state :placed, :initial => true
  	state :versions_submitted
  	state :version_selected
  	state :completed

  	event :submit_versions do
      transitions :from => :placed, :to => :versions_submitted
    end

    event :select_version do
      transitions :from => :versions_submitted, :to => :version_selected
    end

    event :start_new_stage do
      transitions :from => :version_selected, :to => :versions_submitted
    end

    event :complete do
      transitions :from => :versions_submitted, :to => :completed
    end

  end
end
