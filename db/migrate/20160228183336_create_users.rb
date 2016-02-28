class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :unique => true
      t.string :username, :unique => true

      t.timestamps
    end
  end
end
