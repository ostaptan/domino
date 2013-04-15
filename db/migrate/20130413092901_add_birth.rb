class AddBirth < ActiveRecord::Migration
  def up
    add_column :users, :birth_date, :datetime
    add_column :users, :location, :string
    add_column :users, :country, :string
    add_column :users, :language, :string
    add_column :users, :about_me, :text
  end

  def down
  end
end
