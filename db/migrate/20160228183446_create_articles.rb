class CreateArticles < ActiveRecord::Migration[4.2]
  def change
    create_table :articles do |t|
      t.string :link
      t.string :quote
      t.string :author

      t.timestamps
    end
  end
end
