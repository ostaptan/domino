class RenameGamesUsersTable < ActiveRecord::Migration
  def up
    drop_table :games_users
    drop_table :users_games
    create_table :domino_games_users, :id => false do |t|
    t.references :user
    t.references :domino_game
    end
  end

  def down
  end
end
