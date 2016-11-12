class RenameTypeToTypePreferenceOfOrder < ActiveRecord::Migration[5.0]
  def change
  	rename_column :orders, :type, :preference_type
  end
end
