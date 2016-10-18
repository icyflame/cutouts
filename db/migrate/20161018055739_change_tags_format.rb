class ChangeTagsFormat < ActiveRecord::Migration
  def self.up
		change_column :articles, :tags, :string, :default => ""
  end
	def self.down
		change_column :articles, :tags, :string, :default => "--- []\n"
	end
end
