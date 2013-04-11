class AddGameRating < ActiveRecord::Migration
  def up
    add_column :games, :rating, :integer, :default => 1200
  end

  def down
  end
end
