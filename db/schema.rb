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

ActiveRecord::Schema.define(:version => 20120209184704) do

  create_table "account_cookies", :force => true do |t|
    t.string  "secret"
    t.integer "user_id"
  end

  add_index "account_cookies", ["secret"], :name => "index_account_cookies_on_secret", :unique => true

  create_table "account_githubs", :force => true do |t|
    t.string  "token"
    t.integer "github_id"
    t.integer "user_id"
  end

  add_index "account_githubs", ["github_id"], :name => "index_account_githubs_on_github_id", :unique => true
  add_index "account_githubs", ["token"], :name => "index_account_githubs_on_token", :unique => true

  create_table "comments", :force => true do |t|
    t.boolean  "question",    :default => false
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "likes_count", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "favorite_posts_lovers", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "favorite_posts_lovers", ["post_id", "user_id"], :name => "index_favorite_posts_lovers_on_post_id_and_user_id", :unique => true

  create_table "followers", :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
  end

  add_index "followers", ["user_id", "tag_id"], :name => "index_followers_on_user_id_and_tag_id", :unique => true

  create_table "gists", :force => true do |t|
    t.integer "user_id"
    t.integer "source_id"
    t.string  "source_type"
    t.integer "github_id"
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "likes", ["user_id", "likable_id", "likable_type"], :name => "index_likes_on_user_id_and_likable_id_and_likable_type", :unique => true

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.boolean  "read",            :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "notifications", ["user_id", "notifiable_id", "notifiable_type"], :name => "notifications_users_notifiables", :unique => true

  create_table "posts", :force => true do |t|
    t.integer  "comments_count", :default => 0
    t.integer  "likes_count",    :default => 0
    t.text     "content"
    t.integer  "state_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "posts_tags", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "posts_tags", ["post_id", "tag_id"], :name => "index_posts_tags_on_post_id_and_tag_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "home_page"
    t.string   "github_page"
    t.string   "gravatar_id"
    t.datetime "created_at"
  end

end
