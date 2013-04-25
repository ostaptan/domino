class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|

      t.string :type, :default => :small
      t.string :name
      t.integer :g_rating, :default => 500
      t.integer :s_rating, :default => 500
      t.string :glory, :default => 0
      t.integer :leader_id
      t.string :avatar, :default => 'no_avatar_clan.jpg'


      t.timestamps
    end
  end
end
