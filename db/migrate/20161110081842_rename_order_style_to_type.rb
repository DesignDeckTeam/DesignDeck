class RenameOrderStyleToType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :orders, :style, :type
  end
end
