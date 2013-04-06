class CreateHistories < ActiveRecord::Migration
  def change
    drop_table :histories
    create_table :histories do |t|
      t.integer :user_id
      t.integer :g_max_rating
      t.integer :s_max_rating
      t.integer :g_min_rating
      t.integer :g_best_won_from_player_id
      t.integer :s_best_won_from_player_id
      t.integer :g_worst_lost_from_player_id
      t.integer :s_worst_lost_from_player_id
      t.integer :g_a_lost,  :default => 0
      t.integer :s_a_lost,  :default => 0
      t.integer :g_a_won, :default => 0
      t.integer :s_a_won, :default => 0

      t.timestamps
    end
  end
end
