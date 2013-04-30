class AddUserRememberMeToken < ActiveRecord::Migration
  def up
    add_column :users, :remember_me_token, :string
  end

  def down
  end
end
