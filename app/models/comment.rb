class Comment < ActiveRecord::Base

	before_create :set_created_at
	before_update :set_updated_at

	def set_created_at
		self.created_at = Time.now
		self.updated_at = Time.now
	end

	def set_updated_at
		self.updated_at = Time.now
	end

	validates_presence_of :body,message: " is required"

	belongs_to :post
end
