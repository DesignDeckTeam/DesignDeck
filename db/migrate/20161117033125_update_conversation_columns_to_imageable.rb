class UpdateConversationColumnsToImageable < ActiveRecord::Migration[5.0]
  def change
  	add_column :mailboxer_conversations, :conversationable_id, :integer
  	add_column :mailboxer_conversations, :conversationable_type, :string
  end
end
