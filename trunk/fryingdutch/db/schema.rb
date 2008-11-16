# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081116071814) do

  create_table "comments", :force => true do |t|
    t.integer  "comment_on_id",   :limit => 11
    t.string   "comment_on_type"
    t.integer  "content_id",      :limit => 11
    t.string   "content_type"
    t.integer  "user_id",         :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",                      :default => "comment"
    t.integer  "position",        :limit => 11
  end

  create_table "game_metadatas", :force => true do |t|
    t.integer  "game_id",             :limit => 11
    t.string   "website"
    t.string   "forum"
    t.string   "community_site"
    t.string   "publisher"
    t.string   "publisher_url"
    t.string   "developer"
    t.string   "developer_url"
    t.date     "release_date"
    t.string   "players_worldwide"
    t.string   "players_netherlands"
    t.string   "languages"
    t.float    "cost"
    t.string   "cost_period"
    t.boolean  "micro_payments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_ratings", :force => true do |t|
    t.integer  "game_id",    :limit => 11
    t.integer  "user_id",    :limit => 11
    t.float    "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued",     :limit => 11
    t.integer "lifetime",   :limit => 11
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :limit => 11, :null => false
    t.string  "server_url"
    t.string  "salt",                     :null => false
  end

  create_table "screenshots", :force => true do |t|
    t.integer  "parent_id",    :limit => 11
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :limit => 11
    t.integer  "taggable_id",   :limit => 11
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "text_comments", :force => true do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_games", :force => true do |t|
    t.integer  "game_id",      :limit => 11
    t.integer  "user_id",      :limit => 11
    t.date     "start_date"
    t.date     "end_date"
    t.string   "quit_reason"
    t.string   "quit_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity_url"
    t.string   "display_name"
    t.string   "nickname"
    t.string   "email"
    t.integer  "login_counter", :limit => 11
    t.date     "dob"
    t.string   "permalink"
  end

end
