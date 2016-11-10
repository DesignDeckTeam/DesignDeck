# == Schema Information
#
# Table name: versions
#
#  id                  :integer          not null, primary key
#  order_id            :integer
#  image_from_designer :string
#  image_from_customer :string
#  for_status          :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
