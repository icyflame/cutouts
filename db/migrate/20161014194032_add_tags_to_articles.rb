class AddTagsToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :tags, :string, array: true, default: []
  end
end
