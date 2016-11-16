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
#  current_stage_id     :integer
#  image                :string
#  style_and_regulation :text
#  price                :float
#  deadline             :datetime
#  designer_id          :integer
#

class Order < ApplicationRecord
	mount_uploader :image, ImageUploader

	has_many :stages
	belongs_to :user
  accepts_nested_attributes_for :stages, :allow_destroy => true

  scope :available_for, -> (user){ where("designer_id is null OR designer_id = ?", user.id) }

  include AASM

  aasm do
  	state :placed, :initial => true
  	state :versions_submitted
  	state :version_selected
  	state :completed

  	event :submit_initial_versions do
      transitions :from => :placed, :to => :versions_submitted
    end

    event :select_version do
      transitions :from => :versions_submitted, :to => :version_selected
    end

    event :submit_new_versions do
      transitions :from => :version_selected, :to => :versions_submitted
    end

    event :complete do
      transitions :from => :versions_submitted, :to => :completed
    end
  end

  def current_stage
    stage = Stage.find_by(id: self.current_stage_id)
    if stage.blank?
      stage = new_stage
    end
    stage
  end

  def new_stage
    stage = self.stages.build
    stage.save
    self.current_stage_id = stage.id
    self.save
    stage
  end

  def set_current_stage(stage)
    self.current_stage_id = stage.id
    self.save
  end

  def last_selected_version
    Version.where(stage: self.stages.ids).where(aasm_state: "selected").last
  end

  def set_designer?(designer)
    if self.designer_id.blank?
      self.update_columns(designer_id: designer.id)
      true
    else
      false
    end
  end





end
