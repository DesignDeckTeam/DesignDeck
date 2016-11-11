class RenameTypeToTypePreferenceOfOrder < ActiveRecord::Migration[5.0]
  def change
  	rename_column :orders, :type, :type_preference
  end
end
