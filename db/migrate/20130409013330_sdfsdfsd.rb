class Sdfsdfsd < ActiveRecord::Migration
  def up
    #add_column :games, :min_rating, :integer, :default => 10
    #add_column :games, :max_rating, :integer, :default => 10
    add_column :games, :started_at, :datetime
  end

  def down
  end
end
