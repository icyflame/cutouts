class Article < ActiveRecord::Base
	belongs_to :user
	validates :link, :quote, :author, presence: true
  validates :link, format: { with: URI::regexp, message: "Field must be a valid URL! Include http or https in the URL." }
  default_scope { order(created_at: :desc) }

	# This function has become long and complicated because of 
	# a complex migration from the ActiveRecord serialized version of
	# arrays (stored as YAML) back to a normal comma-separated string
	def tags_array
		# http://stackoverflow.com/a/17641383/2080089
		return self.tags.split(',').uniq.map(&:strip)
	end

	def self.search input
		return where("LOWER(quote) like LOWER('%#{input}%') 
								 or LOWER(author) like LOWER('%#{input}%') 
								 or LOWER(link) like LOWER('%#{input}%') 
								 or LOWER(tags) like LOWER('%#{input}')")
	end

	def self.searchForTag input
		return where("LOWER(tags) like LOWER('%#{input}%')")
	end
end
