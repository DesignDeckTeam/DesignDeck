class AddTalentToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :talent, :string
  end
end
