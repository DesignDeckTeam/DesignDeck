class CreateDesignerProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :designer_products do |t|
      t.integer :user_id
      t.string :designer_product

      t.timestamps
    end
  end
end
