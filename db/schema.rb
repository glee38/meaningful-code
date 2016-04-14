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

ActiveRecord::Schema.define(version: 20160414204941) do

  create_table "developer_projects", force: :cascade do |t|
    t.integer "developer_id"
    t.integer "project_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.string "github"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.text   "about_me"
  end

  create_table "nonprofits", force: :cascade do |t|
    t.string "name"
    t.text   "cause"
    t.text   "tagline"
    t.string "website"
    t.string "username"
    t.string "password_digest"
    t.string "email"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "project_specs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_date"
    t.integer  "nonprofit_id"
  end

end
