class Sdfsdfsdfggg < ActiveRecord::Migration
  def up
    add_column :dashboard_comments, :active, :boolean, default: true
    add_column :dashboard_comments, :closed_at, :datetime
    add_column :dashboard_comments, :likers, :text
    add_column :dashboard_comments, :dislikers, :text
  end

  def down
  end
end
