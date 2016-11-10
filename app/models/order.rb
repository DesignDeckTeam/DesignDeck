# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  style       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  aasm_state  :string
#

class Order < ApplicationRecord

	has_many :versions

  include AASM

  aasm do
  end
end
