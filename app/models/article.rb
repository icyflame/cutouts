class Article < ActiveRecord::Base
	belongs_to :user
	validates :link, :quote, presence: true

	def self.search input
		return where("quote like '%#{input}%' or author like '%#{input}%' or link like '%#{input}%'")
	end
end
