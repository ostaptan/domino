class AddGameColumns < ActiveRecord::Migration
  def up
    add_column :games, :players_count, :integer, :default => 2
  end

  def down
  end
end
