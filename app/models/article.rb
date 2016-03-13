class Article < ActiveRecord::Base
	belongs_to :user
	validates :link, :quote, presence: true
end
