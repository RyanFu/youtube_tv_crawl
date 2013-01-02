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

ActiveRecord::Schema.define(:version => 20130102053808) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "youtube_sources", :force => true do |t|
    t.string   "link"
    t.integer  "ep_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "embed_text"
  end

  add_index "youtube_sources", ["ep_id"], :name => "index_youtube_sources_on_ep_id"

end
