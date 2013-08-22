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

ActiveRecord::Schema.define(:version => 20130821234908) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_url"
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "article_id"
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"
  add_index "comments", ["review_id"], :name => "index_comments_on_review_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "rating"
    t.integer  "user_id"
    t.string   "product"
    t.string   "category"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "image_url"
    t.boolean  "approved",   :default => false
  end

  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "review_id"
  end

  add_index "taggings", ["article_id"], :name => "index_taggings_on_article_id"
  add_index "taggings", ["review_id"], :name => "index_taggings_on_review_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "article_author",  :default => false
  end

end
