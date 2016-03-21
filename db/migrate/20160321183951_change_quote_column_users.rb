class ChangeQuoteColumnUsers < ActiveRecord::Migration
  def self.up
		change_column :articles, :quote, :text
  end

	def self.down
		change_column :articles, :quote, :string
	end
end
