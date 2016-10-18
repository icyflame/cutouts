class Article < ActiveRecord::Base
	belongs_to :user
	validates :link, :quote, presence: true

	# This function has become long and complicated because of 
	# a complex migration from the ActiveRecord serialized version of
	# arrays (stored as YAML) back to a normal comma-separated string
	def tags_array
		if self.tags.kind_of?(String)
			if self.tags.match(/\-\-\-\s\[\]/) or self.tags.match(/\-\-\-\s\[/)
				require 'yaml'
				puts "DEBUG: Found stray YAML!"
				puts "DEBUG: #{YAML.load(self.tags)}"
				if YAML.load(self.tags)
					self.tags = YAML.load(self.tags)
				end
			end
		end
		if self.tags.kind_of? Hash
			self.tags = self.tags.values.join(",")
		end
		if self.tags.kind_of? Array
			self.tags = self.tags.join(",")
		end
		if self.tags == "{}" or self.tags == "[]" or self.tags == "--- []\n" or self.tags == {} or self.tags == false or self.tags == "false"
			self.tags = ""
		end
		self.save!
		# http://stackoverflow.com/a/17641383/2080089
		return self.tags.split(',').uniq.map(&:strip)
	end

	def self.search input
		return where("quote like '%#{input}%' or author like '%#{input}%' or link like '%#{input}%'")
	end
end
