class Article < ActiveRecord::Base
	serialize :tags, Array
	belongs_to :user
	validates :link, :quote, presence: true
	before_save :split_tags

	def split_tags
		self.tags = self.tags.split(',').uniq
	end
end
