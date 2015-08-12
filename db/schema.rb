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

ActiveRecord::Schema.define(version: 20150807183822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "admin_accounts", ["user_id"], name: "index_admin_accounts_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "linkedin_accounts", force: :cascade do |t|
    t.string   "access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "linkedin_owner_id"
    t.string   "linkedin_owner_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "linkedin_posts", force: :cascade do |t|
    t.datetime "publish_time"
    t.string   "text"
    t.string   "linkedin_id"
    t.boolean  "shares_created"
    t.integer  "admin_account_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "linkedin_posts", ["admin_account_id"], name: "index_linkedin_posts_on_admin_account_id", using: :btree

  create_table "linkedin_shares", force: :cascade do |t|
    t.datetime "publish_time"
    t.boolean  "completed"
    t.integer  "linkedin_post_id"
    t.integer  "user_account_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "linkedin_shares", ["linkedin_post_id"], name: "index_linkedin_shares_on_linkedin_post_id", using: :btree
  add_index "linkedin_shares", ["user_account_id"], name: "index_linkedin_shares_on_user_account_id", using: :btree

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "access_token"
    t.string   "access_token_secret"
    t.string   "screen_name"
    t.integer  "twitter_owner_id"
    t.string   "twitter_owner_type"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "is_valid",            default: true
  end

  create_table "twitter_posts", force: :cascade do |t|
    t.datetime "publish_time"
    t.string   "text"
    t.string   "twitter_id"
    t.boolean  "shares_created",   default: false
    t.integer  "admin_account_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "twitter_shares", force: :cascade do |t|
    t.datetime "publish_time"
    t.boolean  "completed",       default: false
    t.integer  "twitter_post_id"
    t.integer  "user_account_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "publish_after"
  end

  add_index "twitter_shares", ["twitter_post_id"], name: "index_twitter_shares_on_twitter_post_id", using: :btree
  add_index "twitter_shares", ["user_account_id"], name: "index_twitter_shares_on_user_account_id", using: :btree

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_accounts", ["user_id"], name: "index_user_accounts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_master_user",         default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "admin_accounts", "users"
  add_foreign_key "linkedin_posts", "admin_accounts"
  add_foreign_key "linkedin_shares", "linkedin_posts"
  add_foreign_key "linkedin_shares", "user_accounts"
  add_foreign_key "twitter_shares", "twitter_posts"
  add_foreign_key "twitter_shares", "user_accounts"
  add_foreign_key "user_accounts", "users"
end
