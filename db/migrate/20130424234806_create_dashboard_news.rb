class CreateDashboardNews < ActiveRecord::Migration
  def change
    create_table :dashboard_news do |t|
      t.integer :user_id, :nil => false
      t.text :content
      t.string :header
      t.integer :likes, :default => 0



      t.timestamps
    end
  end
end
