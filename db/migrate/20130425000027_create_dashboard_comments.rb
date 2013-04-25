class CreateDashboardComments < ActiveRecord::Migration
  def change
    create_table :dashboard_comments do |t|
      t.integer :user_id
      t.string :content
      t.integer :likes, :default => 0

      t.timestamps
    end
  end
end
