class AddClanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clan_id, :integer
  end
end
