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
#  product_quantity     :integer          default(1)
#  total_price          :integer
#  attachment           :string
#  rating               :integer
#

class Order < ApplicationRecord
	mount_uploader :image, ImageUploader
	validates :title, :description, presence: true
	mount_uploader :attachment, AttachmentUploader

	has_many :stages
	belongs_to :user
  accepts_nested_attributes_for :stages, :allow_destroy => true

  scope :available_for, -> (user){ where("(designer_id is null AND aasm_state != 'placed') OR designer_id = ?", user.id) }

  include AASM

  aasm do
  	state :placed, :initial => true
    state :paid
    state :picked
    state :drafts_submitted
    state :draft_selected
  	state :versions_submitted
  	state :version_selected
  	state :completed

    event :pay do
      transitions :from => :placed, :to => :paid
    end

    event :pick do
      transitions :paid => :placed, :to => :picked
    end

    event :submit_drafts do 
      transitions from: :picked, to: :drafts_submitted
    end

    event :select_draft do 
      transitions from: :drafts_submitted, to: :draft_selected
    end    

  	event :submit_initial_version do
      transitions :from => :draft_selected, :to => :versions_submitted
    end

    event :select_version do
      transitions :from => :versions_submitted, :to => :version_selected
    end

    event :submit_new_version do
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

  def state_cn
    case self.aasm_state
    when "placed"
      return "客户已下单"
    when "paid"
      return "客户已付款"
    when "picked"
      return "设计师已接单"
    when "versions_submitted"
      return "设计师已提交"
    when "version_selected"
      return "客户已确认"
    when "completed"
      return "订单已完成"
    end
  end

  def new_stage
    stage = self.stages.build
    stage.save
    self.current_stage_id = stage.id
    self.save
    stage
  end

  def last_closed_stage
    self.stages.where(aasm_state: "closed").last
  end

  def versioned_stages
    self.stages.where(id: Version.select(:stage_id).uniq)
  end


  # 最后一个有version的stage
  def last_versioned_stage
    # if self.stages.last.versions.present?
    #   return self.stages.last
    # else
    #   return self.stages.closed.last
    # end
    self.versioned_stages.last
  end

  def last_message
    if self.stages.last.conversation.present?
      return self.stages.last.conversation.messages.last
    elsif self.last_closed_stage.conversation.present?
      return self.last_closed_stage.conversation.messages.last
    end    
  end

  def set_current_stage(stage)
    self.current_stage_id = stage.id
    self.save
  end

  def last_selected_version
    Version.where(stage: self.stages.ids).where(aasm_state: "selected").last
  end

  def designer
    User.find_by(id:self.designer_id)
  end

  def set_designer?(designer)
    if self.designer_id.blank? && self.may_pick?
      self.update_columns(designer_id: designer.id)
      self.pick!
      true
    else
      false
    end
  end

end
