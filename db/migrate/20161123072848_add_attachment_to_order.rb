class AddAttachmentToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :attachment, :string
  end
end
