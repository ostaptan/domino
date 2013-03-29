class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :history_id
      t.string :name
      t.string :surname
      t.integer :message_id
      t.integer :game_id
      t.string :login
      t.string :password
      t.string :email
      t.string :phone
      t.integer :friend_id
      t.integer :tournament_id
      t.integer :portal_id

      t.timestamps
    end
  end
end
