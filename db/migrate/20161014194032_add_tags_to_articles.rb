class AddTagsToArticles < ActiveRecord::Migration[4.2]
  def change
  	add_column :articles, :tags, :string, default: [], array: true
  end
end
