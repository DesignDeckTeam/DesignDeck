class RenameDesignerProductDesignerProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :designer_product, :designer_products
  end
end
