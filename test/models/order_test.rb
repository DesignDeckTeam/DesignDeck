# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :text
#  preference_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  aasm_state      :string
#  user_id         :integer
#  sample_number   :integer
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
