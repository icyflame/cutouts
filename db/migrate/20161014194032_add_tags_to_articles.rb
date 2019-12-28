class AddTagsToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :tags, :string, default: [].to_json, array: true
  end
end
