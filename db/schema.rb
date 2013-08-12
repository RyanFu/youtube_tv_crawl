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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130808040503) do

  create_table "advertisements", :force => true do |t|
    t.string   "title"
    t.string   "imageurl"
    t.text     "description"
    t.boolean  "is_show",     :default => false
    t.integer  "type_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "appprojects", :force => true do |t|
    t.string   "name"
    t.string   "iconurl"
    t.string   "pack"
    t.string   "clas"
    t.string   "promo_title"
    t.string   "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "imageurl"
    t.text     "description"
    t.string   "inverse_title"
    t.string   "inverse_imageurl"
    t.text     "precaution"
    t.boolean  "is_show",          :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "device_watch_infos", :force => true do |t|
    t.string   "registration_id", :null => false
    t.integer  "drama_id"
    t.text     "watched_ep"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "device_watch_infos", ["registration_id"], :name => "index_device_watch_infos_on_registration_id"

  create_table "devices", :force => true do |t|
    t.string   "registration_id", :default => ""
    t.string   "device_id",       :default => ""
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "drama_histories", :force => true do |t|
    t.string   "release_date", :null => false
    t.string   "dramas_str",   :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "dramas", :force => true do |t|
    t.string   "name"
    t.string   "name_en"
    t.integer  "area_id"
    t.text     "introduction"
    t.string   "poster_url"
    t.text     "actors"
    t.string   "directors"
    t.integer  "eps_count",    :default => 0
    t.string   "release_date"
    t.string   "link"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_show",      :default => false
    t.integer  "views",        :default => 0
    t.text     "eps_num_str"
    t.boolean  "is_show_v2",   :default => false
  end

  add_index "dramas", ["area_id"], :name => "index_dramas_on_area_id"

  create_table "eps", :force => true do |t|
    t.string   "title"
    t.integer  "drama_id"
    t.integer  "num"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "eps", ["drama_id"], :name => "index_eps_on_drama_id"

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "registration_id"
    t.string   "serial_num"
    t.integer  "campaign_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "tickets", ["campaign_id"], :name => "index_tickets_on_campaign_id"

  create_table "youtube_sources", :force => true do |t|
    t.string   "link"
    t.integer  "ep_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "embed_text"
  end

  add_index "youtube_sources", ["ep_id"], :name => "index_youtube_sources_on_ep_id"

end
