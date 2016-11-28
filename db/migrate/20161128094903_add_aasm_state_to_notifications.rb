class AddAasmStateToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :aasm_state, :string
  end
end
