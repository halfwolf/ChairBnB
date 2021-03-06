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

ActiveRecord::Schema.define(version: 20141106194915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",       precision: 6, scale: 2
    t.string   "room_type"
    t.string   "chair_type"
    t.string   "street"
    t.string   "city"
    t.integer  "zip_code"
    t.integer  "seats"
    t.float    "lon"
    t.float    "lat"
  end

  add_index "listings", ["chair_type"], name: "index_listings_on_chair_type", using: :btree
  add_index "listings", ["lon", "lat"], name: "index_listings_on_lon_and_lat", using: :btree
  add_index "listings", ["room_type"], name: "index_listings_on_room_type", using: :btree
  add_index "listings", ["seats"], name: "index_listings_on_seats", using: :btree
  add_index "listings", ["zip_code"], name: "index_listings_on_zip_code", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "read",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "listing_id"
    t.integer  "ord",              default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "chair_id",                                               null: false
    t.integer  "sitter_id",                                              null: false
    t.string   "status",                             default: "PENDING"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date",                                             null: false
    t.datetime "end_date",                                               null: false
    t.decimal  "price",      precision: 6, scale: 2
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
    t.integer  "rating",         limit: 2
  end

  add_index "reviews", ["reservation_id"], name: "index_reviews_on_reservation_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               null: false
    t.string   "name",                null: false
    t.string   "password_digest",     null: false
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "omniauth_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["omniauth_id"], name: "index_users_on_omniauth_id", using: :btree

end
