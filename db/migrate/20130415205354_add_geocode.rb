class AddGeocode < ActiveRecord::Migration
  def up
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end

  def down
  end
end
