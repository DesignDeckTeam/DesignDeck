class UpdateConversationColumnsToImageable < ActiveRecord::Migration[5.0]
  def change
  	add_column :mailboxer_conversations, :conversationable_id, :integer
  	add_column :mailboxer_conversations, :conversationable_type, :string
  	add_column :mailboxer_conversations, :x_position_in_sample, :float
  	add_column :mailboxer_conversations, :y_position_in_sample, :float
  end
end
