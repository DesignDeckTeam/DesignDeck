require 'test_helper'

class SampleCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: sample_comments
#
#  id         :integer          not null, primary key
#  sample_id  :integer
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
