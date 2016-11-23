class AddProductQuantityToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :product_quantity, :integer, :default => 1
  end
end
