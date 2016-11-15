class AddDesignerProductToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :designer_product, :string
  end
end
