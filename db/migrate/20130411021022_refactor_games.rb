class RefactorGames < ActiveRecord::Migration
  def up
    remove_column :domino_games, :bones
    add_column :domino_games, :data, :text
  end

  def down
  end
end
