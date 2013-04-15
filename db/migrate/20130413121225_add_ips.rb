class AddIps < ActiveRecord::Migration
  def up
    add_column :users, :ip_address, :string
    add_column :users, :last_ip, :string
  end

  def down
  end
end
