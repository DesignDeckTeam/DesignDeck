class OrderAddDesignerIdAndDeleteSampleNumber < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :designer_id, :integer
  	remove_column :orders, :sample_number
  end
end
