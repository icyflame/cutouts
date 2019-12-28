class ChangeTagsFormat < ActiveRecord::Migration[4.2]
  def self.up
		change_column :articles, :tags, :string, :default => ""
  end
	def self.down
		change_column :articles, :tags, :string, :default => "--- []\n"
	end
end
