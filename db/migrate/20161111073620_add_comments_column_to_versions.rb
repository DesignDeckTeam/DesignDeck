class AddCommentsColumnToVersions < ActiveRecord::Migration[5.0]
  def change
  	add_column :versions, :comment_from_customer, :text
  	add_column :versions, :comment_from_designer, :text  	
  end
end
