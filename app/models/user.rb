# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_designer            :boolean
#  name                   :string
#  designer_intro         :text
#  designer_products      :string
#  token                  :string
#  role                   :integer
#  is_admin               :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  enum role: {用户: 0, 设计师: 1, 管理员: 2 }
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :用户
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploaders :designer_products, DesignerProductsUploader

  acts_as_messageable

  before_create :generate_token

  serialize :designer_products, JSON

  include Gravtastic
  gravtastic

  has_many :orders

  def send_message(recipients, msg_body, subject, resource, sanitize_text = true, attachment = nil, message_timestamp = Time.now)
    conversation = Mailboxer::ConversationBuilder.new(subject: subject,
                                               created_at: message_timestamp,
                                               updated_at: message_timestamp).build

    message = Mailboxer::MessageBuilder.new(sender: self,
                                            conversation: conversation,
                                            recipients: recipients,
                                            body: msg_body,
                                            subject: subject,
                                            attachment: attachment,
                                            created_at: message_timestamp,
                                            updated_at: message_timestamp).build

    conversation.update_attribute(:conversationable_id, resource.id)
    conversation.update_attribute(:conversationable_type, resource.class)

    # recommended by Xdite
    # conversation.conversationable = resource
    conversation.save

    message.deliver false, sanitize_text
  end

  def is_user?
    # !is_designer
    self.role == "用户"
  end

  def designer?
    # is_designer
    self.role == "设计师"
  end

  def qualified_designer?
    self.role == "设计师" && self.is_designer
  end

  def unqualified_designer?
    self.role == "设计师" && !self.is_designer
  end

  def admin?
    self.role == "管理员"
    is_admin
  end

  def approve!
    self.is_designer = true
    self.save
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end
