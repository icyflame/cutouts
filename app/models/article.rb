class Article < ActiveRecord::Base
	belongs_to :user
	validates :link, :quote, presence: true

	def tags_array
		if self.tags.kind_of?(String)
			if self.tags.scan(/\-\-\-\s\[\]/) or self.tags.scan(/\-\-\-\s\[/)
				require 'yaml'
				puts "DEBUG: Found stray YAML!"
				puts "DEBUG: #{YAML.load(self.tags)}"
				self.tags = YAML.load(self.tags)
			end
		end
		if self.tags.kind_of? Hash
			self.tags = self.tags.values.join(",")
		end
		if self.tags.kind_of? Array
			self.tags = self.tags.join(",")
		end
		if self.tags == "{}" or self.tags == "[]" or self.tags == "--- []\n"
			self.tags = ""
		end
		# http://stackoverflow.com/a/17641383/2080089
		self.tags = self.tags.split(',').uniq.map(&:strip)
	end

	def self.search input
		return where("quote like '%#{input}%' or author like '%#{input}%' or link like '%#{input}%'")
	end
end
