class AddDesignerProfileToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :designer_intro, :text
    add_column :users, :designer_production_image, :string
  end
end
