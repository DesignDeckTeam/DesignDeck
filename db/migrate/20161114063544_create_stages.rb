class CreateStages < ActiveRecord::Migration[5.0]
  def change
    create_table :stages do |t|
      t.integer :order_id

      t.timestamps
    end
  end
end
