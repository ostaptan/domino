class Sfdafsd < ActiveRecord::Migration
  def up
    remove_column :users, :uid
    add_column :users, :uid, :string
  end

  def down
  end
end
