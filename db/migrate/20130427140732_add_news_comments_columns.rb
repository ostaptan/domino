class AddNewsCommentsColumns < ActiveRecord::Migration
  def up
    add_column :dashboard_comments, :active, :boolean, default: true
    add_column :dashboard_comments, :closed_at, :datetime
    add_column :dashboard_comments, :likers, :text
    add_column :dashboard_comments, :dislikers, :text
    add_column :dashboard_comments, :post_id, :integer
  end

  def down
  end
end
