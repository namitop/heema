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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160531100038) do

  create_table "tvs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "introduction"
    t.integer  "theme_color"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tvs", ["user_id", "created_at"], name: "index_tvs_on_user_id_and_created_at"
  add_index "tvs", ["user_id"], name: "index_tvs_on_user_id"

  create_table "tvshows", force: :cascade do |t|
    t.integer  "tv_id"
    t.string   "introduction"
    t.text     "video_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tvshows", ["tv_id", "created_at"], name: "index_tvshows_on_tv_id_and_created_at"
  add_index "tvshows", ["tv_id"], name: "index_tvshows_on_tv_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "introduction"
    t.string   "theme_color"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
