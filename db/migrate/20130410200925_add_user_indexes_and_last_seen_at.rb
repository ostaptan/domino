class AddUserIndexesAndLastSeenAt < ActiveRecord::Migration
  def up
    add_column :users, :last_seen_at, :datetime
    remove_column :users, :login
    add_index :users, :email
    add_index :users, :g_rating
    add_index :users, :s_rating

    add_index :games, :game_type
    add_index :games, :time_per_move
    add_index :games, :players_count
    add_index :games, :rating

  end

  def down
  end
end
