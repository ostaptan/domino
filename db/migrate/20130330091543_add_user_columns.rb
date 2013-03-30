class AddUserColumns < ActiveRecord::Migration
  def up
    #add_column :users, :active, :boolean, :default => false
    #add_column :users, :gender, :string, :limit => 1
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :avatar, :string
    add_column :users, :settings, :string
  end

  def down
  end
end
