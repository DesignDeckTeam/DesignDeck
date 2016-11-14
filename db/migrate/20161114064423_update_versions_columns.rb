class UpdateVersionsColumns < ActiveRecord::Migration[5.0]
  def change
  	rename_column :versions, :order_id, :stage_id
  end
end
