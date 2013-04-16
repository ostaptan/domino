# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130415222407) do

  create_table "countries", :force => true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "game_type"
    t.integer  "time_per_move", :default => 1
    t.integer  "winner_id"
    t.integer  "players_count", :default => 2
    t.datetime "finished_at"
    t.datetime "started_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "rating",        :default => 1200
    t.text     "data"
  end

  add_index "games", ["game_type"], :name => "index_games_on_game_type"
  add_index "games", ["players_count"], :name => "index_games_on_players_count"
  add_index "games", ["rating"], :name => "index_games_on_rating"
  add_index "games", ["time_per_move"], :name => "index_games_on_time_per_move"

  create_table "games_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "g_max_rating"
    t.integer  "s_max_rating"
    t.integer  "g_min_rating"
    t.integer  "g_best_won_from_player_id"
    t.integer  "s_best_won_from_player_id"
    t.integer  "g_worst_lost_from_player_id"
    t.integer  "s_worst_lost_from_player_id"
    t.integer  "g_a_lost",                    :default => 0
    t.integer  "s_a_lost",                    :default => 0
    t.integer  "g_a_won",                     :default => 0
    t.integer  "s_a_won",                     :default => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "message"
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.integer  "tournament_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "active",                     :default => false
    t.string   "gender",        :limit => 1
    t.boolean  "is_admin",                   :default => false
    t.string   "avatar"
    t.string   "settings"
    t.integer  "g_rating",                   :default => 1200
    t.integer  "s_rating",                   :default => 1200
    t.datetime "last_seen_at"
    t.datetime "birth_date"
    t.string   "location"
    t.string   "country"
    t.string   "language"
    t.text     "about_me"
    t.string   "ip_address"
    t.string   "last_ip"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["g_rating"], :name => "index_users_on_g_rating"
  add_index "users", ["s_rating"], :name => "index_users_on_s_rating"

  create_table "users_games", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
