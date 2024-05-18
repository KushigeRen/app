# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_16_141311) do
  create_table "groups", primary_key: "group_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "group_name", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", primary_key: "member_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "member_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "fk_rails_e330ef0ccc"
  end

  create_table "payments", primary_key: "payment_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "creditor_member_id", null: false
    t.bigint "debtor_member_id", null: false
    t.bigint "group_id", null: false
    t.integer "amount", null: false
    t.date "payment_date", null: false
    t.date "payment_deadline"
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creditor_member_id"], name: "fk_rails_b72b49199c"
    t.index ["debtor_member_id"], name: "fk_rails_d6dca917e5"
  end

  add_foreign_key "members", "groups", primary_key: "group_id"
  add_foreign_key "payments", "members", column: "creditor_member_id", primary_key: "member_id"
  add_foreign_key "payments", "members", column: "debtor_member_id", primary_key: "member_id"
end
