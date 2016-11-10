class OrderTableAddUserIdAasmSampleNo < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :user_id, :integer
  	add_column :orders, :sample_number, :integer
  end
end
