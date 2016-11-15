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

ActiveRecord::Schema.define(version: 20161115093250) do

  create_table "orders", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "preference_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "aasm_state"
    t.integer  "user_id"
    t.integer  "current_stage_id"
    t.string   "image"
    t.text     "style_and_regulation"
    t.float    "price"
    t.datetime "deadline"
    t.integer  "designer_id"
  end

  create_table "sample_comments", force: :cascade do |t|
    t.integer  "sample_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stage_comments", force: :cascade do |t|
    t.integer  "stage_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "aasm_state"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_designer"
    t.string   "name"
    t.text     "designer_intro"
    t.string   "designer_production_image"
    t.string   "designer_products"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "stage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "aasm_state"
  end

end
