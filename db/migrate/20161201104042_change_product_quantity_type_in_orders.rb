class ChangeProductQuantityTypeInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :product_quantity, :integer, :default => 1
  end
end
