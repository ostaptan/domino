class CreateGames < ActiveRecord::Migration
  def change
    drop_table :games
    create_table :games do |t|
      t.text :bones
      t.string :type, nil => false
      t.integer :time_per_move, :default => 1
      t.integer :winner_id

      t.timestamps
    end
  end
end
