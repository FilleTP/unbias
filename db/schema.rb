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

ActiveRecord::Schema.define(version: 2021_12_01_110902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "author"
    t.string "description"
    t.string "image"
    t.string "url"
    t.string "source"
    t.date "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "category"
    t.string "country"
    t.string "language"
    t.string "token"
    t.float "sentiment"
  end

  create_table "comparisons", force: :cascade do |t|
    t.string "topic"
    t.date "start_date"
    t.date "end_date"
    t.string "country_one"
    t.string "country_two"
    t.string "publisher_one"
    t.string "publisher_two"
    t.string "api_error"
    t.string "comparison_name"
    t.string "comparison_desription"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "articles_one"
    t.json "articles_two"
    t.json "selected_articles_one"
    t.json "selected_articles_two"
    t.string "sentiment_one"
    t.string "sentiment_two"
    t.index ["user_id"], name: "index_comparisons_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "comparison_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_entries_on_article_id"
    t.index ["comparison_id"], name: "index_entries_on_comparison_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "source_keyword"
    t.float "latitude"
    t.float "longitude"
    t.string "img"
    t.string "img_cloudinary"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comparisons", "users"
  add_foreign_key "entries", "articles"
  add_foreign_key "entries", "comparisons"
end
