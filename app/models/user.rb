# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string           default(""), not null
#  encrypted_password        :string           default(""), not null
#  reset_password_token      :string
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0), not null
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string
#  last_sign_in_ip           :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  is_designer               :boolean
#  name                      :string
#  designer_intro            :text
#  designer_production_image :string
#  designer_products         :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploaders :designer_products, ImageUploader

  serialize :designer_products, JSON

  include Gravtastic
  gravtastic

  has_many :orders

  def is_user
    !is_designer
  end

  def designer?
    is_designer
  end
end
