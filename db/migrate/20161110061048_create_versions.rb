class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.integer :order_id
      t.string :image_from_designer
      t.string :image_from_customer
      t.string :for_status

      t.timestamps
    end
  end
end
