# == Schema Information
#
# Table name: samples
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  version_id :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#




class Sample < ApplicationRecord
  belongs_to :user
  belongs_to :version, optional: true
  has_many :sample_comments

  mount_uploader :image, ImageUploader

  validates :image, presence: :true


end

