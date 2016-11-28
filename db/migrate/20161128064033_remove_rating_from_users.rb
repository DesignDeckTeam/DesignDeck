class RemoveRatingFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :rating
  end
end
