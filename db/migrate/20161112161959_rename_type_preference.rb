class RenameTypePreference < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :preference_type, :preference_type
  end
end
