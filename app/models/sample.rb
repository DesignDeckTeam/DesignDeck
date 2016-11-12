class Sample < ApplicationRecord
  belongs_to :user
  belongs_to :version, optional: true

  mount_uploader :image, ImageFromDesignerUploader
end

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
