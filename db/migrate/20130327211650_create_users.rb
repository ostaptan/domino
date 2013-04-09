class CreateUsers < ActiveRecord::Migration
  def change
    drop_table :users

    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :login
      t.string :password
      t.string :email
      t.string :phone
      t.integer :tournament_id

      t.timestamps
    end
  end
end
