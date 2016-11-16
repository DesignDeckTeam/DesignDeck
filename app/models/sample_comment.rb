class SampleComment < ApplicationRecord
	belongs_to :sample
	belongs_to :user
end

# == Schema Information
#
# Table name: sample_comments
#
#  id         :integer          not null, primary key
#  sample_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
