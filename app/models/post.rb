class Post < ActiveRecord::Base
	before_create :set_created_at
	before_update :set_updated_at

	def set_created_at
		self.created_at = Time.now
		self.updated_at = Time.now
	end

	def set_updated_at
		self.updated_at = Time.now
	end

	validates_presence_of :title,message: " is required"
	has_many :comments, dependent: :destroy
end
