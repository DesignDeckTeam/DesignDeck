class RemoveDesignerProductionImageFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :designer_production_image
  end
end
