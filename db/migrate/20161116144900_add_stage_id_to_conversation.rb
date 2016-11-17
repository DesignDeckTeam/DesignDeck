class AddStageIdToConversation < ActiveRecord::Migration[5.0]
  def change
  	add_column :mailboxer_conversations, :stage_id, :integer
  end
end
