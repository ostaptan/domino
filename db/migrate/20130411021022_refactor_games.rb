class RefactorGames < ActiveRecord::Migration
  def up
    remove_column :games, :bones
    add_column :games, :data, :text
  end

  def down
  end
end
