class CreateStageComments < ActiveRecord::Migration[5.0]
  def change
    create_table :stage_comments do |t|
      t.integer :stage_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
