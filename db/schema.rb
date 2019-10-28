# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_13_203808) do

  create_table "monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 190, null: false
    t.integer "hp", null: false
    t.integer "atk", null: false
    t.integer "def", null: false
    t.integer "exp", null: false
    t.integer "money", null: false
    t.integer "img_id"
    t.integer "rarity", null: false
    t.integer "speed", null: false
    t.integer "mp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_monsters_on_name", unique: true
  end

  create_table "user_monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "monster_id", null: false
    t.index ["user_id"], name: "index_user_monsters_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 190, null: false
    t.string "salt", null: false
    t.string "passwd", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  create_table "wallets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "gem", null: false
    t.integer "money", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "user_monsters", "users"
  add_foreign_key "wallets", "users"
end
