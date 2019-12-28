class ChangeQuoteColumnUsers < ActiveRecord::Migration[4.2]
  def self.up
		change_column :articles, :quote, :text
  end

	def self.down
		change_column :articles, :quote, :string
	end
end
