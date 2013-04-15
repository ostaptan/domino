class AddUserColumns < ActiveRecord::Migration
  def up
    add_column :users, :active, :boolean, :default => false
    add_column :users, :gender, :string, :limit => 1
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :avatar, :string, :default => 'no_avatar'
    add_column :users, :settings, :string
    add_column :users, :g_rating, :integer, :default => 1200
    add_column :users, :s_rating, :integer, :default => 1200

  end

  def down
  end
end
