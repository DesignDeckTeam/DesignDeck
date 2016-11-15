require 'test_helper'

class StageCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: stage_comments
#
#  id         :integer          not null, primary key
#  stage_id   :integer
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
