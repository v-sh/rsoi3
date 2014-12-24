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

ActiveRecord::Schema.define(version: 20141123184726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_app_permissions", force: true do |t|
    t.integer  "oauth_account_id"
    t.integer  "api_application_id"
    t.string   "permitted_scopes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_applications", force: true do |t|
    t.string   "name"
    t.string   "client_id"
    t.string   "client_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_accounts", force: true do |t|
    t.string   "email"
    t.string   "telephone"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_codes", force: true do |t|
    t.string   "code"
    t.string   "token"
    t.integer  "account_app_permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refresh_token"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "displayName"
    t.string   "gplus_url"
    t.string   "image_url"
    t.string   "about_me"
    t.string   "gender"
    t.string   "gplus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
