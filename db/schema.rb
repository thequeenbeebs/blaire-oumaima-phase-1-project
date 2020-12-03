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

ActiveRecord::Schema.define(version: 2020_12_03_195659) do

  create_table "add_to_lists", force: :cascade do |t|
    t.integer "gift_id"
    t.integer "list_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "quantity"
    t.string "status"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "shopping_or_wish"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
  end

end
