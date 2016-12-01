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
  has_many :notifications
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


  def stage_cn_for(user)
    if user.is_user?
      state_cn_user
    else
      state_cn_designer
    end
  end

  def state_cn_user
    case self.aasm_state
    when "placed"
      return "已下单"
    when "paid"
      return "待接单"
    when "picked"
      return "已有设计师接单"
    when "drafts_submitted"
      return "初稿已提交"
    when "draft_selected"
      return "等待新稿件"
    when "versions_submitted"
      return "收到新稿件"
    when "version_selected"
      return "已发送反馈"
    when "completed"
      return "订单已完成"
    end
  end

  def state_cn_designer
    case self.aasm_state
    when "placed"
      return "客户已下单"
    when "paid"
      return "可接单"
    when "picked"
      return "已接单"
    when "drafts_submitted"
      return "方案待确定"
    when "draft_selected"
      return "方案已确定"
    when "versions_submitted"
      return "新稿件已发送"
    when "version_selected"
      return "收到新反馈"
    when "completed"
      return "订单已完成"
    end
  end

  def state_cn_admin
    case self.aasm_state
    when "placed"
      return "客户已下单"
    when "paid"
      return "待设计师接单"
    when "picked"
      return "已有设计师接单"
    when "drafts_submitted"
      return "设计师提交了初稿"
    when "draft_selected"
      return "客户已选择风格"
    when "versions_submitted"
      return "设计师提交了新稿件"
    when "version_selected"
      return "客户提交了反馈"
    when "completed"
      return "订单已完成"
    end
  end

  def hint_cn_for(user)
    if user.is_user?
      hint_cn_user
    else
      hint_cn_designer
    end
  end

  def hint_cn_user
    case self.aasm_state
    when "placed"
      return "待付款"
    when "paid"
      return "等待设计师接单"
    when "picked"
      return "已有设计师接单，请等待ta向您发送初稿供您选择"
    when "drafts_submitted"
      return "请在下面多种不同风格的稿件中选择一款，并向设计师提出您选择的理由，以便后续改进"
    when "draft_selected"
      return "设计师会根据您的选择的风格设计下一版稿件，请等待"
    when "versions_submitted"
      return "设计师发来了新稿件，点击图片可以对图片加批注，在下面写下您的反馈，设计师会看到并更新，或者如果您对此版本稿件感到满意，可以确定为最终稿"
    when "version_selected"
      return "您的反馈已经发送，请等待设计师的下一版稿件"
    when "completed"
      if self.attachment.present?
        return "订单已完成，请下载设计师上传的最终打包文件"
      else
        return "已定稿，等待设计师为您发送最终稿件的打包文件"
      end
    end
  end

  def hint_cn_designer
    case self.aasm_state
    when "placed"
      return "用户未付款"
    when "paid"
      return "可接这一单"
    when "picked"
      return "请为客户提供至少3种不同风格的初稿，发送后客户会从中选择出他喜欢的一种风格"
    when "drafts_submitted"
      return "等待客户选择初稿的风格"
    when "draft_selected"
      return "客户已经选择了初稿的风格，您可以根据客户在对话框中的反馈制作下一版稿件，今后的提交每次只需要提交一版稿件即可（一版稿件可以存放多张图片）"
    when "versions_submitted"
      return "新稿件已提交，等待客户的反馈"
    when "version_selected"
      return "客户提交了反馈，可能在您前一版稿件中的图片加了批注，对话框中也会有ta的意见，根据客户的反馈制作下一版稿件吧~ 今后的提交每次只需要提交一版稿件即可（一版稿件可以存放多张图片）"
    when "completed"
      if self.attachment.present?
        return "最终版本的稿件打包文件已经上传，您也可以再次为客户上传更新的稿件打包文件"
      else
        return "客户已经定稿，您需要为客户提供最终版本的稿件打包文件"
      end
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
    self.stages.where(id: Version.select(:stage_id).uniq).order("id")
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

  def unread_notifications_for_user(user)
    self.notifications.where(aasm_state: "unread").where(receiver_id: user.id)
  end

end
