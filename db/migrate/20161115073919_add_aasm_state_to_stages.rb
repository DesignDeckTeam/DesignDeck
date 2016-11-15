class AddAasmStateToStages < ActiveRecord::Migration
  def change
    add_column :stages, :aasm_state, :string
  end
end
