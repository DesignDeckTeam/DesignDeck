class CreateSampleComments < ActiveRecord::Migration[5.0]
  def change
    create_table :sample_comments do |t|
      t.integer :sample_id
      t.integer :user_id

      t.timestamps
    end
  end
end
