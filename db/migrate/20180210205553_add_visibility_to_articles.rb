class AddVisibilityToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :visibility, :integer, :default => 0
  end
end
