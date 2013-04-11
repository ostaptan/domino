class CreateGames < ActiveRecord::Migration
  def change
    drop_table :games
    create_table :games do |t|
      t.text :bones
      t.string :game_type, nil => false
      t.integer :time_per_move, :default => 1
      t.integer :winner_id
      t.integer :players_count, :default => 2
      t.datetime :finished_at
      t.datetime :started_at
      t.integer :min_rating, :default => 10
      t.integer :max_rating, :default => 10

      t.timestamps
    end
  end
end
