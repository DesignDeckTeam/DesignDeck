class AddImageToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :image, :string
  end
end
