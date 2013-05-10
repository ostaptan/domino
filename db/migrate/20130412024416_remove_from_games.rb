class RemoveFromGames < ActiveRecord::Migration
  def up
    remove_column :domino_games, :min_rating
    remove_column :domino_games, :max_rating
  end

  def down
  end
end
