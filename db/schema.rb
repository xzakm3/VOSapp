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

ActiveRecord::Schema.define(version: 20170625161143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appliances", force: :cascade do |t|
    t.text "name"
    t.index ["name"], name: "index_appliances_on_name", unique: true, using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.integer "count",                       null: false
    t.integer "performance_of_appliance_id"
    t.index ["performance_of_appliance_id"], name: "index_entries_on_performance_of_appliance_id", using: :btree
  end

  create_table "entry_rooms", force: :cascade do |t|
    t.integer "entry_id"
    t.integer "room_id"
    t.integer "user_id"
    t.index ["entry_id"], name: "index_entry_rooms_on_entry_id", using: :btree
    t.index ["room_id"], name: "index_entry_rooms_on_room_id", using: :btree
    t.index ["user_id", "room_id"], name: "index_entry_rooms_on_user_id_and_room_id", using: :btree
    t.index ["user_id"], name: "index_entry_rooms_on_user_id", using: :btree
  end

  create_table "performance_of_appliances", force: :cascade do |t|
    t.integer "performance",  null: false
    t.integer "appliance_id"
    t.index ["appliance_id"], name: "index_performance_of_appliances_on_appliance_id", using: :btree
    t.index ["performance"], name: "index_performance_of_appliances_on_performance", using: :btree
  end

  create_table "performances", force: :cascade do |t|
    t.integer "value"
  end

  create_table "registration_in_suppliers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "supplier_id"
    t.date    "from"
    t.date    "to"
    t.index ["supplier_id"], name: "index_registration_in_suppliers_on_supplier_id", using: :btree
    t.index ["user_id"], name: "index_registration_in_suppliers_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.text "name"
    t.index ["name"], name: "index_rooms_on_name", unique: true, using: :btree
  end

  create_table "scenario_of_appliances", force: :cascade do |t|
    t.integer "number_of_up"
    t.integer "entry_room_id"
    t.integer "scenario_id"
    t.index ["entry_room_id"], name: "index_scenario_of_appliances_on_entry_room_id", using: :btree
    t.index ["scenario_id"], name: "index_scenario_of_appliances_on_scenario_id", using: :btree
  end

  create_table "scenarios", force: :cascade do |t|
    t.integer "power"
    t.integer "user_id"
    t.index ["user_id"], name: "index_scenarios_on_user_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.text    "name"
    t.integer "fix_sum"
    t.integer "vt"
    t.integer "nt"
    t.index ["name"], name: "index_suppliers_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "password_digest",   limit: 60
    t.text     "email"
    t.text     "address",                                      null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "remember_digest"
    t.boolean  "admin",                        default: false
    t.string   "activation_digest"
    t.boolean  "activated",                    default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["address"], name: "index_users_on_address", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "entries", "performance_of_appliances"
  add_foreign_key "entry_rooms", "entries"
  add_foreign_key "entry_rooms", "rooms"
  add_foreign_key "entry_rooms", "users"
  add_foreign_key "performance_of_appliances", "appliances"
  add_foreign_key "scenario_of_appliances", "entry_rooms"
  add_foreign_key "scenario_of_appliances", "scenarios"
  add_foreign_key "scenarios", "users"
end
