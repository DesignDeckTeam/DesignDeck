class AddImageStyleAndRegulationToOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :image, :string
  	add_column :orders, :style_and_regulation, :text
  	add_column :orders, :price, :float
  	add_column :orders, :deadline, :datetime
  end
end
