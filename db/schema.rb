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

ActiveRecord::Schema.define(version: 20141029132907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",       precision: 6, scale: 2
  end

  create_table "reservations", force: true do |t|
    t.integer  "chair_id",                       null: false
    t.datetime "start",                          null: false
    t.datetime "end",                            null: false
    t.integer  "sitter_id",                      null: false
    t.string   "status",     default: "PENDING"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["chair_id"], name: "index_reservations_on_chair_id", using: :btree
  add_index "reservations", ["sitter_id"], name: "index_reservations_on_sitter_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "author_id"
    t.integer  "reservation_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["reservation_id"], name: "index_reviews_on_reservation_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
