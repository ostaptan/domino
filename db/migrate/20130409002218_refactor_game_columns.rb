class RefactorGameColumns < ActiveRecord::Migration
  def up
    #remove_column :games, :type
    #add_column :games, :game_type, :string, nil => false
  end

  def down
  end
end
