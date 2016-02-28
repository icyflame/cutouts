class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :link
      t.string :quote
      t.string :author

      t.timestamps
    end
  end
end
