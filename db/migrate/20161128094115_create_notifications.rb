class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.string :link
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :order_id

      t.timestamps
    end
  end
end
