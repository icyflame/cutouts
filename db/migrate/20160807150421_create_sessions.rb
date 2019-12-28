class CreateSessions < ActiveRecord::Migration[4.2]
  def change
    create_table :sessions do |t|
      t.string :sid
      t.string :user_id

      t.timestamps
    end
  end
end
