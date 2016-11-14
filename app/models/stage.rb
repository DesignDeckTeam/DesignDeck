class Stage < ApplicationRecord
	belongs_to :order
	has_many :stage_comments
	has_many :versions
end

# == Schema Information
#
# Table name: stages
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
