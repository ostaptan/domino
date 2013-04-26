class AddNewsColumns < ActiveRecord::Migration
  def up
    add_column :dashboard_news, :active, :boolean, default: true
    add_column :dashboard_news, :closed_at, :datetime
    add_column :dashboard_news, :likers, :text
    add_column :dashboard_news, :dislikers, :text
    remove_column :clans, :glory
    add_column :clans, :glory, :integer, default: 0
  end

  def down
  end
end
