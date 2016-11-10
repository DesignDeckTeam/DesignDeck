class AddDesignerToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :is_designer, :boolean
  end
end
