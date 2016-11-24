# == Schema Information
#
# Table name: mailboxer_conversations
#
#  id                    :integer          not null, primary key
#  subject               :string           default("")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  conversationable_id   :integer
#  conversationable_type :string
#  x_position_in_sample  :float
#  y_position_in_sample  :float
#

require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get conversations_index_url
    assert_response :success
  end

  test "should get show" do
    get conversations_show_url
    assert_response :success
  end

end
