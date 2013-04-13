class RemoveFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :min_rating
    remove_column :games, :max_rating
  end

  def down
  end
end
