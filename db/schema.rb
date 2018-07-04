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

ActiveRecord::Schema.define(version: 20180612144701) do

  create_table "dbconnections", force: :cascade do |t|
    t.string   "adapter"
    t.string   "mode"
    t.string   "host"
    t.string   "port"
    t.string   "username"
    t.string   "password"
    t.string   "database"
    t.string   "encoding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimates", force: :cascade do |t|
    t.string   "name"
    t.string   "customer"
    t.integer  "customer_id"
    t.string   "notes"
    t.integer  "item_count"
    t.integer  "item_variations",     default: 1
    t.boolean  "include_case",        default: true
    t.boolean  "include_master_case", default: false
    t.float    "unit_weight"
    t.float    "discount",            default: 0.0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "fulfillment_bills", force: :cascade do |t|
    t.string   "store_name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "customer_id"
    t.integer  "store_id"
    t.boolean  "include_fulfillment_charge", default: true
    t.boolean  "include_usps_charge",        default: true
    t.string   "custom_sql"
    t.string   "custom_fulfillment_sql"
    t.string   "custom_shipping_charge_sql"
    t.string   "custom_order_list_sql"
  end

  create_table "restconnections", force: :cascade do |t|
    t.string   "host"
    t.string   "appname"
    t.string   "appid"
    t.string   "description"
    t.string   "debug"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                               null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
