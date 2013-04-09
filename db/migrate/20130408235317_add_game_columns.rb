class AddGameColumns < ActiveRecord::Migration
  def up
    add_column :games, :players_count, :integer, :default => 2
    add_column :games, :finished_at, :datetime
  end

  def down
  end
end
