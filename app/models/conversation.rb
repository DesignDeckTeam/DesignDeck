class Conversation < Mailboxer::Conversation

  # Mailboxer::Conversation的subclass
  belongs_to :conversationable, polymorphic: true

end

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
#
