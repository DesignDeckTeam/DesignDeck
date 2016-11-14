class AddCurrentStageToOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :current_stage, :integer
  end
end
