class CreateSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      t.integer :user_id
      t.integer :version_id
      t.string  :image
      t.timestamps
    end
  end
end
