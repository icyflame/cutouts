class ChangeSizeOfQuoteColumnArticles < ActiveRecord::Migration
  def self.up
		change_column :articles, :quote, :text, :limit => nil
  end

	def self.down
		change_column :articles, :quote, :text, :limit => 255
	end
end
