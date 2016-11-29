class AddRatingToRoles < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :rating, :integer
  end
end
