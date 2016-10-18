class Article < ActiveRecord::Base
	serialize :tags, Array
	belongs_to :user
	validates :link, :quote, presence: true
	before_save :split_tags

	def split_tags
		# http://stackoverflow.com/a/17641383/2080089
		self.tags = self.tags.split(',').uniq.map(&:strip)
	end

	def self.search input
		return where("quote like '%#{input}%' or author like '%#{input}%' or link like '%#{input}%'")
	end
end
