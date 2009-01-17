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

ActiveRecord::Schema.define(:version => 20090117075513) do

  create_table "boards", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "comments", :force => true do |t|
    t.integer  "comment_on_id"
    t.string   "comment_on_type"
    t.integer  "content_id"
    t.string   "content_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",        :default => "comment"
    t.integer  "position"
  end

  create_table "discussion_topics", :force => true do |t|
    t.string   "title"
    t.integer  "icon_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funeral_letters", :force => true do |t|
    t.integer  "funeral_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_metadatas", :force => true do |t|
    t.integer  "game_id"
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
    t.integer  "game_id"
    t.integer  "user_id"
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

  create_table "read_contents", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "screenshots", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
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
    t.integer  "game_id"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "quit_reason"
    t.string   "quit_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "identity_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.date     "dob"
    t.boolean  "gender"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "email"
    t.integer  "login_counter"
    t.string   "permalink"
    t.string   "state",         :default => "registration"
  end

  create_table "wow_characters", :force => true do |t|
    t.string   "name"
    t.string   "realm"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
