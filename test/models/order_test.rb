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

<<<<<<< HEAD
#  product_quantity     :integer          default(1)
#  total_price          :integer
=======
#  attachment           :string
>>>>>>> develop
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
