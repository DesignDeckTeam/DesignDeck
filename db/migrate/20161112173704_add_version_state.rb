class AddVersionState < ActiveRecord::Migration[5.0]
  def change
    add_column :versions, :aasm_state, :string
  end
end
