
# == Schema Information
#
# Table name: versions
#
#  id                    :integer          not null, primary key
#  order_id              :integer
#  image_from_designer   :string
#  image_from_customer   :string
#  for_status            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  comment_from_customer :text
#  comment_from_designer :text
#

class Version < ApplicationRecord


mount_uploader :image_from_designer, ImageFromDesignerUploader
mount_uploader :image_from_customer, ImageFromCustomerUploader
	belongs_to :order

	scope :samples_for_order, -> (order) { where(order_id: order.id).where(for_status: "EXAMPLE").where.not(image_from_designer: nil) }


	def set_status!(status)
		self.update_columns(for_status: status)
	end

	def set_image_from_designer(image)
		self.image_from_designer = image
		self.save
	end

	def set_image_from_customer(image)
		self.image_from_customer = image
		self.save
	end

	def has_image_from_designer
		self.image_from_designer.present?
	end

	def has_image_from_customer
		self.image_from_customer.present?
	end	

	def set_comment_from_customer(comment)
		self.update_columns(comment_from_customer: comment)
	end

end

