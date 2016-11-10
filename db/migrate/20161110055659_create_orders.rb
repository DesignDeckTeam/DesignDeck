class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :description
      t.string :style

      t.timestamps
    end
  end
end
